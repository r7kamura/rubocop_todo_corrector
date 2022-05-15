# frozen_string_literal: true

require 'yaml'

module RubocopTodoCorrector
  class GemNamesDetector
    class << self
      # @param [String] rubocop_configuration_path
      # @return [Array<String>]
      def call(rubocop_configuration_path:)
        new(rubocop_configuration_path:).call
      end
    end

    def initialize(rubocop_configuration_path:)
      @rubocop_configuration_path = rubocop_configuration_path
    end

    def call
      gem_names
    end

    private

    # @return [Hash]
    def configuration_hash
      ::YAML.load_file(@rubocop_configuration_path)
    end

    # @return [Array<String>]
    def gem_names
      requires.grep(/\A[\w-]+\z/)
    end

    # @return [Array<String>]
    def requires
      configuration_hash['require'] || []
    end
  end
end
