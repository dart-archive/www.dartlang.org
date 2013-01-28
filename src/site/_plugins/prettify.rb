# Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

require 'cgi'

module Prettify

  # Renders a table with code and a running example side by side.
  class Tag < Liquid::Block

    def initialize(tag_name, lang, tokens)
      super
      @lang = lang
    end

    def render(context)
      '<pre class="prettyprint lang-' + @lang + '">' + CGI::escapeHTML(super.strip) + "</pre>"
    end

  end
end

Liquid::Template.register_tag('prettify', Prettify::Tag)
