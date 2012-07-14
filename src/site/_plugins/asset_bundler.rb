#
# Jekyll Asset Bundler
#
# Author : Colin Kennedy
# Repo   : http://github.com/moshen/jekyll-asset_bundler
# License: MIT, see LICENSE file
#

require 'yaml'
require 'digest/md5'
require 'net/http'
require 'uri'

module Jekyll

  class BundleTag < Liquid::Block
    @@supported_types = ['js', 'css']

    def initialize(tag_name, text, tokens)
      super
      @text = text 
      @files = {}
    end

    def render(context)
      src = context.registers[:site].source
      raw_markup = super(context)
      begin
        @assets = YAML::load(raw_markup)
      rescue
        puts <<-END
Asset Bundler - Error: Problem parsing a YAML bundle
#{raw_markup}

#{$!}
END
      end

      if @assets.class != Array
        puts "Asset Bundler - Error: YAML bundle is not an Array\n#{raw_markup}"
        @assets = []
      end

      add_files_from_list(src, @assets)

      markup = ""

      @files.each {|k,v|
        markup.concat(Bundle.new(v, k, context).markup())
      }

      markup
    end

    def add_files_from_list(src, list)
      list.each {|a|
        path = File.join(src, a)
        if (File.basename(a) !~ /^\.+/ and File.file?(path)) or a =~ /^(https?:)?\/\//i
          add_file_by_type(a)
        else
          puts "Asset Bundler Error - File: #{path} not found, ignoring..."
        end
      }
    end

    def add_file_by_type(file)
      if file =~ /\.([^\.]+)$/
        type = $1.downcase()
        return if @@supported_types.index(type).nil?
        if !@files.key?(type)
          @files[type] = []
        end

        @files[type].push(file)
      end
    end

  end

  class BundleGlobTag < BundleTag
    def add_files_from_list(src, list)
      list.each {|a|
        Dir.glob(File.join(src, a)) {|f|
          if f !~ /^\.+/ and File.file?(f)
            add_file_by_type(f.sub(src,''))
          end
        }
      }
    end

  end

  class DevAssetsTag < BundleTag
    def render(context)
      if Bundle.config(context)['dev']
        super(context)
      else
        ''
      end
    end

    def add_files_from_list(src, list)
      list.each {|a|
        add_file_by_type(a)
      }
    end
  end

  class Bundle
    @@bundles = {}
    @@default_config = {
      'compile'        => { 'coffee' => false, 'less' => false },
      'compress'       => { 'js'     => false, 'css'  => false },
      'base_path'      => '/bundles/',
      'remove_bundled' => false,
      'dev'            => false
    }
    attr_reader :content, :hash, :filename, :base

    def initialize(files, type, context)
      @files    = files
      @type     = type
      @context  = context
      @content  = ''
      @hash     = ''
      @filename = ''

      @config = Bundle.config(@context)
      @base = @config['base_path']

      @filename_hash = Digest::MD5.hexdigest(@files.join())
      if @@bundles.key?(@filename_hash)
        @filename = @@bundles[@filename_hash].filename
        @base     = @@bundles[@filename_hash].base
      else
        load_content()
      end
    end

    def self.config(context)
      ret_config = nil
      if context.registers[:site].config.key?("asset_bundler")
        ret_config = @@default_config.deep_merge(context.registers[:site].config["asset_bundler"])
      else
        ret_config = @@default_config
      end

      if context.registers[:site].config.key?("dev")
        ret_config['dev'] = context.registers[:site].config["dev"] ? true : false
      end

      if context.registers[:site].config['server']
        ret_config['dev'] = true
      end

      ret_config
    end

    def load_content()
      if @config['dev']
        @@bundles[@filename_hash] = self
        return
      end

      src = @context.registers[:site].source

      @files.each {|f|
        if f =~ /^(https?:)?\/\//i
          # Make all requests via http
          f = "http:#{f}" if !$1
          f.sub!( /^https/i, "http" ) if $1 =~ /^https/i
          @content.concat(remote_asset_cache(URI(f)))
        else
          @content.concat(File.read(File.join(src, f)))
        end
      }

      @hash = Digest::MD5.hexdigest(@content)
      @filename = "#{@hash}.#{@type}"
      cache_file = File.join(cache_dir(), @filename)

      if File.readable?(cache_file) and @config['compress'][@type]
        @content = File.read(cache_file)
      elsif @config['compress'][@type]
        # TODO: Compilation of Less and CoffeeScript would go here
        compress()
        File.open(cache_file, "w") {|f|
          f.write(@content)
        }
      end

      @context.registers[:site].static_files.push(self)
      remove_bundled() if @config['remove_bundled']

      @@bundles[@filename_hash] = self
    end

    def cache_dir()
      cache_dir = File.expand_path( "../_asset_bundler_cache",
                                    @context.registers[:site].plugins )
      if( !File.directory?(cache_dir) )
        FileUtils.mkdir_p(cache_dir)
      end

      cache_dir
    end

    def remote_asset_cache(uri)
      cache_file = File.join(cache_dir(),
                             "remote.#{Digest::MD5.hexdigest(uri.to_s)}.#{@type}")
      content = ""

      if File.readable?(cache_file)
        content = File.read(cache_file)
      else
        begin
          puts "Asset Bundler - Downloading: #{uri.to_s}"
          content = Net::HTTP.get(uri)
          File.open(cache_file, "w") {|f|
            f.write( content )
          }
        rescue
          puts "Asset Bundler - Error: There was a problem downloading #{f}\n  #{$!}"
        end
      end

      return content
    end

    # Removes StaticFiles from the _site if they are bundled
    #   and the remove_bundled option is true
    #   which... it isn't by default
    def remove_bundled()
      src = @context.registers[:site].source
      @files.each {|f|
        @context.registers[:site].static_files.select! {|s|
          if s.class == StaticFile
            s.path != File.join(src, f)
          else
            true
          end
        }
      }
    end

    def compress()
      return if @config['dev']

      case @config['compress'][@type]
        when 'yui'
          compress_yui()
        when 'closure'
          compress_closure()
        else
          compress_command()
      end
    end

    def compress_command()
      temp_path = cache_dir()
      command = String.new(@config['compress'][@type])
      infile = false
      outfile = false
      used_files = []

      if command =~ /:infile/
        File.open(File.join(temp_path, "infile.#{@filename_hash}.#{@type}"), mode="w") {|f|
          f.write(@content)
          used_files.push( f.path )
          infile = f.path
        }
        command.sub!( /:infile/, "\"#{infile.gsub(File::SEPARATOR,
                               File::ALT_SEPARATOR || File::SEPARATOR)}\"")
      end
      if command =~ /:outfile/
        outfile = File.join(temp_path, "outfile.#{@filename_hash}.#{@type}")
        used_files.push( outfile )
        command.sub!( /:outfile/, "\"#{outfile.gsub(File::SEPARATOR,
                               File::ALT_SEPARATOR || File::SEPARATOR)}\"")
      end

      if infile and outfile
        `#{command}`
      else
        mode = "r"
        mode = "r+" if !infile
        IO.popen(command, mode) {|i|
          if !infile
            i.puts(@content)
            i.close_write()
          end
          @content = i.gets() if !outfile
        }
      end

      if outfile
        @content = File.read( outfile )
      end

      used_files.each {|f|
        File.unlink( f )
      }
    end

    def compress_yui()
      require 'yui/compressor'
      case @type
        when 'js'
          @content = YUI::JavaScriptCompressor.new.compress(@content)
        when 'css'
          @content = YUI::CssCompressor.new.compress(@content)
      end
    end

    def compress_closure()
      require 'closure-compiler'
      case @type
        when 'js'
          @content = Closure::Compiler.new.compile(@content)
      end
    end

    def markup()
      return dev_markup() if @config['dev']
      case @type
        when 'js'
          "<script type='text/javascript' src='#{@base}#{@filename}'></script>\n"
        when 'coffee'
          "<script type='text/coffeescript' src='#{@base}#{@filename}'></script>\n"
        when 'css'
          "<link rel='stylesheet' type='text/css' href='#{@base}#{@filename}' />\n"
        when 'less'
          "<link rel='stylesheet/less' type='text/css' href='#{@base}#{@filename}' />\n"
      end
    end

    def dev_markup()
      output = ''
      @files.each {|f|
        case @type
          when 'js'
            output.concat("<script type='text/javascript' src='#{f}'></script>\n")
          when 'coffee'
            output.concat("<script type='text/coffeescript' src='#{f}'></script>\n")
          when 'css'
            output.concat("<link rel='stylesheet' type='text/css' href='#{f}' />\n")
          when 'less'
            output.concat("<link rel='stylesheet/less' type='text/css' href='#{f}' />\n")
        end
      }

      return output
    end

    # Methods required by Jekyll::Site to write out the bundle
    #   This is where we give Jekyll::Bundle a Jekyll::StaticFile
    #   duck call and send it on its way.
    def destination(dest)
      File.join(dest, @base, @filename)
    end

    def write(dest)
      dest_path = destination(dest)
      return false if File.exists?(dest_path)

      FileUtils.mkdir_p(File.dirname(dest_path))
      File.open(dest_path, "w") {|o|
        o.write(@content)
      }

      true
    end
    # End o' the duck call

  end

end

Liquid::Template.register_tag('bundle'     , Jekyll::BundleTag    )
Liquid::Template.register_tag('bundle_glob', Jekyll::BundleGlobTag)
Liquid::Template.register_tag('dev_assets' , Jekyll::DevAssetsTag )
