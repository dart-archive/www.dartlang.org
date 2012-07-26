module Jekyll

  class DartisansPage < Page
    def initialize(site, base, dir, episode)
      @site = site
      @base = base
      @dir = dir
      @episode = episode
      @name = "dartisans-ep-#{@episode['num']}.markdown"

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'dartisans_episode.markdown')
      self.data['episode'] = @episode
      self.data['title'] = @episode['title']
      self.data['description'] = StripHtmlFilter::strip_html(@episode['description'])
    end
  end

  class DartisansPageGenerator < Generator
    safe true
    
    def generate(site)
      dir = 'dartisans'
      episodes = YAML.load_file(File.join(dir, 'episodes.yaml'))
      episodes['episodes'].each do |episode|
        site.pages << DartisansPage.new(site, site.source, dir, episode)
      end
    end
  end

end