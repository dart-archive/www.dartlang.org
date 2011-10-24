module Jekyll
  class PrettyCodeTag < Liquid::Block

    def initialize(tag_name, params, tokens)
      super
      @params = params.split(' ')
      @lang = (@params[0] || 'dart')
      @linenum = @params[1] || '1'
    end

    def render(context)
      "<pre class=\"prettyprint lang-#{@lang} linenums:#{@linenum}\">" +
      super.join('') +
      "</pre>"
    end
  end
end

Liquid::Template.register_tag('pretty_code', Jekyll::PrettyCodeTag)
