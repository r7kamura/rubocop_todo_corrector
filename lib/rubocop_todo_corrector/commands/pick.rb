# frozen_string_literal: true

require 'pathname'
require 'set'

module RubocopTodoCorrector
  module Commands
    class Pick
      class << self
        # @param [String] ignore_file_path
        # @param [String] mode
        # @param [Boolean] only_safe
        # @param [String] rubocop_todo_path
        def call(
          ignore_file_path:,
          mode:,
          only_safe:,
          rubocop_todo_path:
        )
          new(
            ignore_file_path:,
            mode:,
            only_safe:,
            rubocop_todo_path:
          ).call
        end
      end

      def initialize(
        ignore_file_path:,
        mode:,
        only_safe:,
        rubocop_todo_path:
      )
        @ignore_file_path = ignore_file_path
        @mode = mode
        @only_safe = only_safe
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
          if @only_safe
            cop[:safe_auto_correctable]
          else
            cop[:auto_correctable]
          end
        end
      end

      def check_rubocop_todo_existence
        raise "#{rubocop_todo_pathname.to_s.inspect} does not exist." unless rubocop_todo_pathname.exist?
      end

      # @return [Set<String>]
      def ignored_cop_names
        @ignored_cop_names ||= IgnoreFile.new(
          path: @ignore_file_path
        ).ignored_cop_names.to_set
      end

      # @return [Array<Hash>]
      def pickable_cops
        auto_correctable_cops.reject do |cop|
          ignored_cop_names.include?(cop[:name])
        end
      end

      # @return [Hash, nil]
      def picked_cop
        case @mode
        when 'first'
          pickable_cops.first
        when 'last'
          pickable_cops.last
        when 'least_occurred'
          pickable_cops.min_by do |cop|
            cop[:offenses_count]
          end
        when 'most_occurred'
          pickable_cops.max_by do |cop|
            cop[:offenses_count]
          end
        else
          pickable_cops.sample
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
