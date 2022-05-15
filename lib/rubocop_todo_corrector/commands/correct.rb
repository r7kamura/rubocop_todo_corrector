# frozen_string_literal: true

module RubocopTodoCorrector
  module Commands
    class Correct
      class << self
        # @param [String] temporary_gemfile_path
        def call(
          temporary_gemfile_path:
        )
          new(
            temporary_gemfile_path:
          ).call
        end
      end

      def initialize(
        temporary_gemfile_path:
      )
        @temporary_gemfile_path = temporary_gemfile_path
      end

      def call
        ::Kernel.system(
          { 'BUNDLE_GEMFILE' => @temporary_gemfile_path },
          'bundle exec rubocop --auto-correct-all'
        )
      end
    end
  end
end
