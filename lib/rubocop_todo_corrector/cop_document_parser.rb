# frozen_string_literal: true

require 'yard'

module RubocopTodoCorrector
  class CopDocumentParser
    class << self
      # @param [String] source_path
      # @return [Hash, nil]
      def call(
        source_path:
      )
        new(
          source_path:
        ).call
      end
    end

    def initialize(
      source_path:
    )
      @source_path = source_path
    end

    # @return [Hash, nil]
    def call
      return unless yard_class_object

      {
        description:,
        examples:,
        safety:
      }
    end

    private

    # @return [String]
    def description
      yard_class_object.docstring
    end

    # @return [Array<Hash>]
    def examples
      yard_class_object.tags('example').map do |tag|
        {
          name: tag.name,
          text: tag.text
        }
      end
    end

    # @return [Hash, nil]
    def safety
      tag = yard_class_object.tag('safety')
      return unless tag

      {
        name: tag.name,
        text: tag.text
      }
    end

    # @return [YARD::CodeObjects::ClassObject]
    def yard_class_object
      @yard_class_object ||= begin
        ::YARD::Tags::Library.define_tag('Cop Safety Information', :safety)
        ::YARD.parse(@source_path)
        yardoc = ::YARD::Registry.all(:class).first
        ::YARD::Registry.clear
        yardoc
      end
    end
  end
end
