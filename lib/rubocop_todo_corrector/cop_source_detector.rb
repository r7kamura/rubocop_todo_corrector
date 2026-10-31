# frozen_string_literal: true

require 'open3'

module RubocopTodoCorrector
  class CopSourceDetector
    class << self
      # @param [String] cop_name
      # @param [String] temporary_gemfile_path
      # @return [String, nil]
      def call(
        cop_name:,
        temporary_gemfile_path:
      )
        new(
          cop_name:,
          temporary_gemfile_path:
        ).call
      end
    end

    def initialize(
      cop_name:,
      temporary_gemfile_path:
    )
      @cop_name = cop_name
      @temporary_gemfile_path = temporary_gemfile_path
    end

    # @return [String, nil]
    def call
      output = capture
      output unless output.empty?
    end

    private

    # @return [String]
    def capture
      ::Open3.capture2(
        { 'BUNDLE_GEMFILE' => @temporary_gemfile_path },
        "bundle exec ruby -e 'Bundler.require; #{ruby_code}'"
      ).first
    end

    # Recent RuboCop versions lazy-load cops with autoload, so the constant needs to be loaded before
    # `Object.const_source_location`. Otherwise it returns the location of the autoload call.
    # @return [String]
    def ruby_code
      "Object.const_get(#{cop_class_name.inspect}); print Object.const_source_location(#{cop_class_name.inspect}).first"
    end

    # @return [String]
    def cop_class_name
      "RuboCop::Cop::#{@cop_name.gsub('/', '::')}"
    end
  end
end
