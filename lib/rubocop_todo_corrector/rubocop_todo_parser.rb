# frozen_string_literal: true

module RubocopTodoCorrector
  class RubocopTodoParser
    COP_NAME_LINE_REGEXP = %r{
      ^
      (?<cop_name>
        \w+
        (?:/\w+)*
      )
      :
      $
    }x

    class << self
      # @param [String] content
      def call(content:)
        new(
          content:
        ).call
      end
    end

    def initialize(content:)
      @content = content
    end

    # @return [Hash]
    def call
      {
        cops:,
        previous_rubocop_command:
      }
    end

    private

    # @return [Array<Hash>]
    def cops
      cop_sections.map do |cop_section|
        RubocopTodoSectionParser.call(content: cop_section)
      end
    end

    def previous_rubocop_command
      @content[
        /`(.+)`/,
        1
      ]
    end

    # @return [Array<String>]
    def cop_sections
      @content.split("\n\n").grep(COP_NAME_LINE_REGEXP)
    end
  end
end
