# frozen_string_literal: true

require 'fileutils'

module RubocopTodoCorrector
  module Commands
    class Clean
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
        ::FileUtils.rm_f(
          [
            @temporary_gemfile_path,
            "#{@temporary_gemfile_path}.lock"
          ]
        )
      end
    end
  end
end
