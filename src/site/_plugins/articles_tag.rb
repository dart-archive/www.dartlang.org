require 'yaml'

module Jekyll

  class ArticlesTag < Liquid::Tag
    def initialize(tag_name, section_name, tokens)
      super
      @section_name = section_name.strip
    end

    def render(context)
      @data_file = File.join(context.registers[:site].source, 'articles', 'articles.yaml')
      @articles = YAML.load_file(@data_file)

      section = @articles[@section_name]

      <<-END
        <section id="#{@section_name}">
        <h2>#{section['title']}</h2>
        #{section['articles'].map{|article| render_article(article)}.join("\n")}
        </section>
      END

    end

    def render_article(article)
      <<-END
      <section class="article">
        <h4><a href="#{article['url']}">#{article['title']}</a></h4>
        <div class="author-and-date">#{article['authors'].join(' and ')}, #{article['date']}</div>
        <p>#{article['desc']}</p>
      </section>
      END
    end

  end

end

Liquid::Template.register_tag('articles', Jekyll::ArticlesTag)