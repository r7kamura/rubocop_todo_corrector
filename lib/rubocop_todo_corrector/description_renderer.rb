# frozen_string_literal: true

require 'asciidoctor'
require 'erb'
require 'open3'

module RubocopTodoCorrector
  class DescriptionRenderer
    TEMPLATE_PATH = ::File.expand_path('../../templates/description.md.erb', __dir__)

    class << self
      # @param [String] cop_document
      # @param [String] cop_name
      # @param [String] cop_url
      # @return [String]
      def call(
        cop_document:,
        cop_name:,
        cop_url:
      )
        new(
          cop_document:,
          cop_name:,
          cop_url:
        ).call
      end
    end

    def initialize(
      cop_document:,
      cop_name:,
      cop_url:
    )
      @cop_document = cop_document
      @cop_name = cop_name
      @cop_url = cop_url
    end

    # @return [String]
    def call
      ::ERB.new(template_content, trim_mode: '-').result(binding)
    end

    private

    # Convert AsciiDoc to HTML.
    # @param [String] string
    # @return [String]
    def asciidoc(string)
      ::Asciidoctor.convert(
        string,
        safe: :safe
      )
    end

    # Prepend quote marker to each line.
    # @param [String] string
    # @return [String]
    def quote(string)
      string.each_line.map do |line|
        "> #{line}".strip
      end.join("\n")
    end

    # @return [String]
    def template_content
      ::File.read(TEMPLATE_PATH)
    end
  end
end
