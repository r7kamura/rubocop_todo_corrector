# frozen_string_literal: true

require 'bundler'

module RubocopTodoCorrector
  class GemVersionDetector
    class << self
      # @param [String] gemfile_lock_path
      # @param [String] name
      # @return [String, nil]
      def call(gemfile_lock_path:, gem_name:)
        new(
          gemfile_lock_path: gemfile_lock_path,
          gem_name: gem_name
        ).call
      end
    end

    def initialize(gemfile_lock_path:, gem_name:)
      @gemfile_lock_path = gemfile_lock_path
      @gem_name = gem_name
    end

    # @return [String, nil]
    def call
      specification&.version&.to_s
    end

    private

    # @return [Bundler::LockfileParser]
    def bundler_lockfile_parser
      ::Bundler::LockfileParser.new(gemfile_lock_content)
    end

    # @return [String]
    def gemfile_lock_content
      ::File.read(@gemfile_lock_path)
    end

    # @return [Bundler::LazySpecification]
    def specification
      specs.find do |specification|
        specification.name == @gem_name
      end
    end

    # @return [Array<Bundler::LazySpecification>]
    def specs
      bundler_lockfile_parser.specs
    end
  end
end
