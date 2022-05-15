# frozen_string_literal: true

module RubocopTodoCorrector
  module Commands
    class Bundle
      class << self
        # @param [String] rubocop_configuration_path
        # @param [String] gemfile_lock_path
        # @param [String] temporary_gemfile_path
        def call(
          rubocop_configuration_path:,
          gemfile_lock_path:,
          temporary_gemfile_path:
        )
          new(
            rubocop_configuration_path:,
            gemfile_lock_path:,
            temporary_gemfile_path:
          ).call
        end
      end

      def initialize(
        rubocop_configuration_path:,
        gemfile_lock_path:,
        temporary_gemfile_path:
      )
        @rubocop_configuration_path = rubocop_configuration_path
        @gemfile_lock_path = gemfile_lock_path
        @temporary_gemfile_path = temporary_gemfile_path
      end

      def call
        BundleInstaller.call(
          gem_specifications:,
          temporary_gemfile_path: @temporary_gemfile_path
        )
      end

      private

      # @return [Array<String>]
      def gem_names
        [
          'rubocop',
          *GemNamesDetector.call(rubocop_configuration_path: @rubocop_configuration_path)
        ]
      end

      # @return [Array<Hash>]
      def gem_specifications
        gem_names.map do |gem_name|
          {
            gem_name:,
            gem_version: GemVersionDetector.call(
              gem_name:,
              gemfile_lock_path: @gemfile_lock_path
            )
          }
        end
      end
    end
  end
end
