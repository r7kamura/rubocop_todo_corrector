# frozen_string_literal: true

require 'erb'

module RubocopTodoCorrector
  class DescriptionRenderer
    TEMPLATE_PATH = ::File.expand_path('../../templates/description.md.erb', __dir__)

    class << self
      # @param [String] cop_document
      # @param [String] cop_name
      # @param [String] cop_source_path
      # @return [String]
      def call(
        cop_document:,
        cop_name:,
        cop_source_path:
      )
        new(
          cop_document: cop_document,
          cop_name: cop_name,
          cop_source_path: cop_source_path
        ).call
      end
    end

    def initialize(
      cop_document:,
      cop_name:,
      cop_source_path:
    )
      @cop_document = cop_document
      @cop_name = cop_name
      @cop_source_path = cop_source_path
    end

    # @return [String]
    def call
      ::ERB.new(template_content, trim_mode: '-').result(binding)
    end

    private

    # @return [String]
    def cop_url
      if gem_name
        "https://www.rubydoc.info/gems/#{gem_name}/RuboCop/Cop/#{@cop_name}"
      else
        "https://www.google.com/search?q=rubocop+#{::URI.encode_www_form_component(@cop_name.inspect)}"
      end
    end

    # @return [String, nil]
    def gem_name
      @gem_name ||= @cop_source_path[
        %r{/gems/([\w-]+)-\d+(?:\.\w+)*/lib},
        1
      ]
    end

    # @return [String]
    def template_content
      ::File.read(TEMPLATE_PATH)
    end
  end
end
