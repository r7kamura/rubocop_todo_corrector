# frozen_string_literal: true

require 'erb'
require 'open3'

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
          cop_document:,
          cop_name:,
          cop_source_path:
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
      CopUrlFinder.call(
        cop_name: @cop_name,
        cop_source_path: @cop_source_path,
        temporary_gemfile_path: @temporary_gemfile_path
      )
    end

    # @return [String]
    def template_content
      ::File.read(TEMPLATE_PATH)
    end
  end
end
