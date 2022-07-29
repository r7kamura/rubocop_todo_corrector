# frozen_string_literal: true

require 'pathname'

module RubocopTodoCorrector
  module Commands
    class Generate
      class << self
        # @param [String] rubocop_todo_path
        # @param [String] temporary_gemfile_path
        def call(
          rubocop_todo_path:,
          temporary_gemfile_path:
        )
          new(
            rubocop_todo_path:,
            temporary_gemfile_path:
          ).call
        end
      end

      def initialize(
        rubocop_todo_path:,
        temporary_gemfile_path:
      )
        @rubocop_todo_path = rubocop_todo_path
        @temporary_gemfile_path = temporary_gemfile_path
      end

      def call
        ::Kernel.system(
          { 'BUNDLE_GEMFILE' => @temporary_gemfile_path },
          'bundle exec rubocop --regenerate-todo'
        )
      end
    end
  end
end
