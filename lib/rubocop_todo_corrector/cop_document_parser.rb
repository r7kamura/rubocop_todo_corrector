# frozen_string_literal: true

module RubocopTodoCorrector
  class CopDocumentParser
    class << self
      # @param [String] source_path
      # @return [Hash, nil]
      def call(
        source_path:
      )
        new(
          source_path: source_path
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
        description: yard_class_object.docstring,
        examples: yard_class_object.tags('example').map do |tag|
          {
            name: tag.name,
            text: tag.text
          }
        end
      }
    end

    private

    # @return [YARD::CodeObjects::ClassObject]
    def yard_class_object
      @yard_class_object ||= begin
        ::YARD.parse(@source_path)
        yardoc = ::YARD::Registry.all(:class).first
        ::YARD::Registry.clear
        yardoc
      end
    end
  end
end
