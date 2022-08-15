# frozen_string_literal: true

require 'open3'

module RubocopTodoCorrector
  class CopUrlFinder
    class << self
      # @param [String] cop_name
      # @param [String] cop_source_path
      # @param [String] temporary_gemfile_path
      # @return [String]
      def call(
        cop_name:,
        cop_source_path:,
        temporary_gemfile_path:
      )
        new(
          cop_name:,
          cop_source_path:,
          temporary_gemfile_path:
        ).call
      end
    end

    def initialize(
      cop_name:,
      cop_source_path:,
      temporary_gemfile_path:
    )
      @cop_name = cop_name
      @cop_source_path = cop_source_path
      @temporary_gemfile_path = temporary_gemfile_path
    end

    # @return [String]
    def call
      if !captured_url.empty?
        captured_url
      elsif gem_name
        "https://www.rubydoc.info/gems/#{gem_name}/RuboCop/Cop/#{@cop_name}"
      else
        "https://www.google.com/search?q=rubocop+#{::URI.encode_www_form_component(@cop_name.inspect)}"
      end
    end

    private

    # @return [String, nil]
    def captured_url
      @captured_url ||= ::Open3.capture2(
        { 'BUNDLE_GEMFILE' => @temporary_gemfile_path },
        "bundle exec rubocop --show-docs-url #{@cop_name}"
      ).first.strip
    end

    # @return [String, nil]
    def gem_name
      @gem_name ||= @cop_source_path[
        %r{/gems/([\w-]+)-\d+(?:\.\w+)*/lib},
        1
      ]
    end
  end
end
