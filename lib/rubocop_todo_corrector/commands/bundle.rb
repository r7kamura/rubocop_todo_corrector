# frozen_string_literal: true

require 'yaml'

module RubocopTodoCorrector
  module Commands
    class Bundle
      class << self
        # @param [String] configuration_path
        def call(configuration_path:)
          new(configuration_path: configuration_path).call
        end
      end

      def initialize(configuration_path:)
        @configuration_path = configuration_path
      end

      def call
        p gem_names
      end

      private

      # @return [Array<String>]
      def gem_names
        GemDetector.call(configuration_path: @configuration_path)
      end
    end
  end
end
