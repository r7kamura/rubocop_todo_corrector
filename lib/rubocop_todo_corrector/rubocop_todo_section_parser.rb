# frozen_string_literal: true

module RubocopTodoCorrector
  class RubocopTodoSectionParser
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
        auto_correctable: auto_correctable?,
        name: name,
        offenses_count: offenses_count
      }
    end

    private

    # @return [Boolean]
    def auto_correctable?
      @content.include?('# Cop supports --auto-correct.') ||
        @content.include?('# Cop supports safe auto-correction.') ||
        @content.include?('# Cop supports unsafe auto-correction.')
    end

    # @return [String, nil]
    def name
      @content[/(#{RubocopTodoParser::COP_NAME_LINE_REGEXP})/, 'cop_name']
    end

    # @return [Integer, nil]
    def offenses_count
      @content[
        /^# Offense count: (?<offenses_count>\d+)$/,
        'offenses_count'
      ]&.to_i
    end
  end
end
