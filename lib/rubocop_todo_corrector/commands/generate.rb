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
          "bundle exec #{rubocop_command}"
        )
      end

      private

      # @return [String]
      def rubocop_command
        rubocop_command_from_todo || 'rubocop --auto-gen-config'
      end

      # @return [String, nil]
      def rubocop_command_from_todo
        return unless rubocop_todo_pathname.exist?

        RubocopTodoParser.call(content: rubocop_todo_content)[:previous_rubocop_command]
      end

      # @return [String]
      def rubocop_todo_content
        rubocop_todo_pathname.read
      end

      # @return [Pathname]
      def rubocop_todo_pathname
        @rubocop_todo_pathname ||= ::Pathname.new(@rubocop_todo_path)
      end
    end
  end
end
