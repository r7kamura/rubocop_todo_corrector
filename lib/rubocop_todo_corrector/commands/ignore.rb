# frozen_string_literal: true

require 'pathname'

module RubocopTodoCorrector
  module Commands
    class Ignore
      class << self
        # @param [String] cop_name
        # @param [String] ignore_file_path
        def call(
          cop_name:,
          ignore_file_path:
        )
          new(
            cop_name:,
            ignore_file_path:
          ).call
        end
      end

      def initialize(
        cop_name:,
        ignore_file_path:
      )
        @cop_name = cop_name
        @ignore_file_path = ignore_file_path
      end

      def call
        IgnoreFile.new(path: @ignore_file_path).append_cop_name(@cop_name)
      end
    end
  end
end
