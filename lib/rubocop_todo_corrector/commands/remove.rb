# frozen_string_literal: true

require 'pathname'

module RubocopTodoCorrector
  module Commands
    class Remove
      class << self
        # @param [String] cop_name
        # @param [String] rubocop_todo_path
        def call(
          cop_name:,
          rubocop_todo_path:
        )
          new(
            cop_name:,
            rubocop_todo_path:
          ).call
        end
      end

      def initialize(
        cop_name:,
        rubocop_todo_path:
      )
        @cop_name = cop_name
        @rubocop_todo_path = rubocop_todo_path
      end

      # @return [String]
      def call
        check_rubocop_todo_existence
        write
      end

      private

      def check_rubocop_todo_existence
        raise "#{rubocop_todo_pathname.to_s.inspect} does not exist." unless rubocop_todo_pathname.exist?
      end

      # @return [String]
      def processed_content
        rubocop_todo_content.split("\n\n").grep_v(/^#{@cop_name}:$/).join("\n\n")
      end

      def rubocop_todo
        RubocopTodoParser.call(content: rubocop_todo_content)
      end

      # @return [String]
      def rubocop_todo_content
        rubocop_todo_pathname.read
      end

      # @return [Pathname]
      def rubocop_todo_pathname
        @rubocop_todo_pathname ||= ::Pathname.new(@rubocop_todo_path)
      end

      def write
        ::File.write(
          @rubocop_todo_path,
          processed_content
        )
      end
    end
  end
end
