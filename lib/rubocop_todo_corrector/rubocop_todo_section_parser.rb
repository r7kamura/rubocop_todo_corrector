# frozen_string_literal: true

module RubocopTodoCorrector
  class RubocopTodoSectionParser
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
        auto_correctable:,
        name:,
        offenses_count:,
        safe_auto_correctable:
      }
    end

    private

    # @return [Boolean]
    def auto_correctable
      safe_auto_correctable || unsafe_auto_correctable
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

    def safe_auto_correctable
      @content.include?('# Cop supports --auto-correct.') ||
        @content.include?('# This cop supports safe auto-correction')
    end

    def unsafe_auto_correctable
      @content.include?('# Cop supports --auto-correct-all') ||
        @content.include?('# This cop supports unsafe auto-correction')
    end
  end
end
