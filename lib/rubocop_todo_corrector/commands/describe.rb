# frozen_string_literal: true

module RubocopTodoCorrector
  module Commands
    class Describe
      class << self
        # @param [String] cop_name
        # @param [String] temporary_gemfile_path
        def call(
          cop_name:,
          temporary_gemfile_path:
        )
          new(
            cop_name: cop_name,
            temporary_gemfile_path: temporary_gemfile_path
          ).call
        end
      end

      def initialize(
        cop_name:,
        temporary_gemfile_path:
      )
        @cop_name = cop_name
        @temporary_gemfile_path = temporary_gemfile_path
      end

      def call
        cop_source_path = CopSourceDetector.call(
          cop_name: @cop_name,
          temporary_gemfile_path: @temporary_gemfile_path
        )
        return unless cop_source_path

        cop_document = CopDocumentParser.call(source_path: cop_source_path)
        return unless cop_document

        description = DescriptionRenderer.call(
          cop_document: cop_document,
          cop_name: @cop_name,
          cop_source_path: cop_source_path
        )
        ::Kernel.puts(description)
      end
    end
  end
end
