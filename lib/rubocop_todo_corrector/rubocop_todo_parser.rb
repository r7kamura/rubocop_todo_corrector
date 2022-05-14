# frozen_string_literal: true

module RubocopTodoCorrector
  class RubocopTodoParser
    class << self
      # @param [String] content
      def call(content:)
        new(
          content: content
        ).call
      end
    end

    def initialize(content:)
      @content = content
    end

    # @return [Hash]
    def call
      {
        previous_rubocop_command: previous_rubocop_command
      }
    end

    private

    def previous_rubocop_command
      @content[
        /`(.+)`/,
        1
      ]
    end
  end
end
