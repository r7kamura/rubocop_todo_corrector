# frozen_string_literal: true

require 'yaml'

module RubocopTodoCorrector
  module Commands
    class Install
      class << self
        # @param [String] configuration_path
        # @param [String] gemfile_lock_path
        def call(
          configuration_path:,
          gemfile_lock_path:
        )
          new(
            configuration_path: configuration_path,
            gemfile_lock_path: gemfile_lock_path
          ).call
        end
      end

      def initialize(
        configuration_path:,
        gemfile_lock_path:
      )
        @configuration_path = configuration_path
        @gemfile_lock_path = gemfile_lock_path
      end

      def call
        GemsInstaller.call(gem_specifications: gem_specifications)
      end

      private

      # @return [Array<String>]
      def gem_names
        [
          'rubocop',
          *GemNamesDetector.call(configuration_path: @configuration_path)
        ]
      end

      # @return [Array<Hash>]
      def gem_specifications
        gem_names.map do |gem_name|
          {
            gem_name: gem_name,
            gem_version: GemVersionDetector.call(
              gem_name: gem_name,
              gemfile_lock_path: @gemfile_lock_path
            )
          }
        end
      end
    end
  end
end
