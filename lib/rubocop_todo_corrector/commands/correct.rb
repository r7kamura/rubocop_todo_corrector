# frozen_string_literal: true

module RubocopTodoCorrector
  module Commands
    class Correct
      class << self
        # @param [Boolean] only_safe
        # @param [String] temporary_gemfile_path
        def call(
          only_safe:,
          temporary_gemfile_path:
        )
          new(
            only_safe:,
            temporary_gemfile_path:
          ).call
        end
      end

      def initialize(
        only_safe:,
        temporary_gemfile_path:
      )
        @only_safe = only_safe
        @temporary_gemfile_path = temporary_gemfile_path
      end

      def call
        ::Kernel.system(
          { 'BUNDLE_GEMFILE' => @temporary_gemfile_path },
          "bundle exec rubocop #{rubocop_options}"
        )
      end

      private

      # @return [String]
      def rubocop_options
        if @only_safe
          '--auto-correct'
        else
          '--auto-correct-all'
        end
      end
    end
  end
end
