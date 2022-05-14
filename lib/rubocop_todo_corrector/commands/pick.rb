# frozen_string_literal: true

require 'pathname'

module RubocopTodoCorrector
  module Commands
    class Pick
      class << self
        # @param [String] rubocop_todo_path
        def call(
          rubocop_todo_path:
        )
          new(
            rubocop_todo_path: rubocop_todo_path
          ).call
        end
      end

      def initialize(
        rubocop_todo_path:
      )
        @rubocop_todo_path = rubocop_todo_path
      end

      def call
        check_rubocop_todo_existence
        result = RubocopTodoParser.call(content: rubocop_todo_content)
        auto_correctable_cops = result[:cops].select do |cop|
          cop[:auto_correctable]
        end
        auto_correctable_cop = auto_correctable_cops.sample
        auto_correctable_cop&.[](:name)
      end

      private

      def check_rubocop_todo_existence
        raise "#{rubocop_todo_pathname.to_s.inspect} does not exist." unless rubocop_todo_pathname.exist?
      end

      # @return [Array<Hash>]
      def cops
        RubocopTodoParser.call(content: rubocop_todo_content)[:cops]
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
