# frozen_string_literal: true

require 'pathname'

module RubocopTodoCorrector
  module Commands
    class Pick
      class << self
        # @param [String] mode
        # @param [String] rubocop_todo_path
        def call(
          mode:,
          rubocop_todo_path:
        )
          new(
            mode:,
            rubocop_todo_path:
          ).call
        end
      end

      def initialize(
        mode:,
        rubocop_todo_path:
      )
        @mode = mode
        @rubocop_todo_path = rubocop_todo_path
      end

      def call
        check_rubocop_todo_existence
        cop_name = picked_cop&.[](:name)
        if cop_name
          ::Kernel.puts(cop_name)
        else
          ::Kernel.abort('No cop was picked.')
        end
      end

      private

      # @return [Array<Hash>]
      def auto_correctable_cops
        rubocop_todo[:cops].select do |cop|
          cop[:auto_correctable]
        end
      end

      def check_rubocop_todo_existence
        raise "#{rubocop_todo_pathname.to_s.inspect} does not exist." unless rubocop_todo_pathname.exist?
      end

      # @return [Hash, nil]
      def picked_cop
        case @mode
        when 'first'
          auto_correctable_cops.first
        when 'last'
          auto_correctable_cops.last
        when 'least_occurred'
          auto_correctable_cops.min_by do |cop|
            cop[:offenses_count]
          end
        when 'most_occurred'
          auto_correctable_cops.max_by do |cop|
            cop[:offenses_count]
          end
        else
          auto_correctable_cops.sample
        end
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
    end
  end
end
