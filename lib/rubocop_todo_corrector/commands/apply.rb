# frozen_string_literal: true

require 'pathname'
require 'yaml'

module RubocopTodoCorrector
  module Commands
    class Apply
      class << self
        # @param [String] cop_name
        # @param [Boolean] only_safe
        # @param [String] rubocop_todo_path
        # @param [String] temporary_gemfile_path
        # @return [void]
        def call(
          cop_name:,
          only_safe:,
          rubocop_todo_path:,
          temporary_gemfile_path:
        )
          new(
            cop_name:,
            only_safe:,
            rubocop_todo_path:,
            temporary_gemfile_path:
          ).call
        end
      end

      # @param [String] cop_name
      # @param [Boolean] only_safe
      # @param [String] rubocop_todo_path
      # @param [String] temporary_gemfile_path
      def initialize(
        cop_name:,
        only_safe:,
        rubocop_todo_path:,
        temporary_gemfile_path:
      )
        @cop_name = cop_name
        @only_safe = only_safe
        @rubocop_todo_path = rubocop_todo_path
        @temporary_gemfile_path = temporary_gemfile_path
      end

      # @return [void]
      def call
        check_rubocop_todo_existence
        update_rubocop_todo
        autocorrect_excluded_files
      end

      private

      # @return [void]
      def autocorrect_excluded_files
        ::Kernel.system(
          { 'BUNDLE_GEMFILE' => @temporary_gemfile_path },
          [
            'bundle exec rubocop --force-exclusion', autocorrect_option, *excluded_file_paths
          ].join(' ')
        )
      end

      # @return [String]
      def autocorrect_arguments
        ::Shellwords.shelljoin(excluded_file_paths)
      end

      # @return [String]
      def autocorrect_option
        if @only_safe
          '--auto-correct'
        else
          '--auto-correct-all'
        end
      end

      # @return [void]
      def check_rubocop_todo_existence
        raise "#{rubocop_todo_pathname.to_s.inspect} does not exist." unless rubocop_todo_pathname.exist?
      end

      # @return [Array<String>]
      def excluded_file_paths
        cop_section = rubocop_todo_sections.grep(/^#{@cop_name}:/).first
        raise unless cop_section

        paths = ::YAML.safe_load(cop_section).dig(@cop_name, 'Exclude')
        raise unless paths

        paths
      end

      # @return [String]
      def rubocop_todo_content
        rubocop_todo_pathname.read
      end

      # @return [Array<String>]
      def rubocop_todo_sections
        @rubocop_todo_sections ||= rubocop_todo_content.split("\n\n")
      end

      # @return [String]
      def rubocop_todo_content_without_cop
        content = rubocop_todo_sections.grep_v(/^#{@cop_name}:$/).join("\n\n")
        content += "\n" unless content.end_with?("\n")
        content
      end

      # @return [Pathname]
      def rubocop_todo_pathname
        @rubocop_todo_pathname ||= ::Pathname.new(@rubocop_todo_path)
      end

      # @return [void]
      def update_rubocop_todo
        ::File.write(
          @rubocop_todo_path,
          rubocop_todo_content_without_cop
        )
      end
    end
  end
end
