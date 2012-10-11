# Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

module Jekyll

  # This plugin renders a table with code and a running example side by side.
  class CodeSampleTag < Liquid::Block

    def initialize(tag_name, params, tokens)
      super
      @percent = params.strip
    end

    def render(context)
      link = ""
      if @src_url
        link = "(<a href='#{@src_url}'>see full source</a>)"
      end

      ("\n\n<table sytle='border:0px'><thead>" +
        "<tr><td><strong>Source code #{link}</strong>" +
        "</td><td>" +
        "</td><td><strong>Try it out...</strong></td></tr>" +
        "</thead><tbody><tr>" +
        "<td style='width:#{@percent}%;vertical-align:top;'>" + super.strip +
        "</td><td style='width:100%;'>" +
        "</td><td style='vertical-align:top;'>" +
        "<iframe style='border:none;height:#{@height};width:#{@width};'" +
        " src='#{@url}'></iframe>" +
        "</td></tr></tbody></table>\n\n")
    end

    def unknown_tag(tag, params, tokens)
      case tag
        when 'sample'
          @width, @height, @url = params.split(' ')
        when 'url'
          @src_url = params
        else
          super
      end
    end

  end
end

Liquid::Template.register_tag('codesample', Jekyll::CodeSampleTag)
