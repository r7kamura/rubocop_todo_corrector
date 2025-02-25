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
      requires.grep(/\A[\w-]+\z/) + plugins + inherit_gems
    end

    # @return [Array<String>]
    def plugins
      configuration_hash['plugins'] || []
    end

    # @return [Array<String>]
    def requires
      configuration_hash['require'] || []
    end

    # @return [Array<String>]
    def inherit_gems
      configuration_hash['inherit_gem']&.keys || []
    end
  end
end
