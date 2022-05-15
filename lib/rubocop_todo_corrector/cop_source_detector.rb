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
          cop_name: cop_name,
          temporary_gemfile_path: temporary_gemfile_path
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
        "bundle exec ruby -e 'Bundler.require; print Object.const_source_location(#{cop_class_name.inspect}).first'"
      ).first
    end

    # @return [String]
    def cop_class_name
      "RuboCop::Cop::#{@cop_name.sub('/', '::')}"
    end
  end
end
