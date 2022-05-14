# frozen_string_literal: true

require 'pathname'

module RubocopTodoCorrector
  class BundleInstaller
    class << self
      # @param [Hash] gem_specifications
      # @param [String] temporary_gemfile_path
      def call(
        gem_specifications:,
        temporary_gemfile_path:
      )
        new(
          gem_specifications: gem_specifications,
          temporary_gemfile_path: temporary_gemfile_path
        ).call
      end
    end

    def initialize(
      gem_specifications:,
      temporary_gemfile_path:
    )
      @gem_specifications = gem_specifications
      @temporary_gemfile_path = temporary_gemfile_path
    end

    def call
      make_directory
      write_gemfile
      bundle_install
    end

    private

    def bundle_install
      ::Kernel.system('bundle install')
    end

    # @return [String]
    def gemfile_content
      [
        "source 'https://rubygems.org'",
        *@gem_specifications.map do |gem_specification|
          format(
            "gem '%<gem_name>s', '%<gem_version>s'",
            gem_specification
          )
        end
      ].join("\n") << "\n"
    end

    def make_directory
      pathname.parent.mkpath
    end

    # @return [Pathname]
    def pathname
      @pathname ||= ::Pathname.new(@temporary_gemfile_path)
    end

    def write_gemfile
      pathname.write(gemfile_content)
    end
  end
end
