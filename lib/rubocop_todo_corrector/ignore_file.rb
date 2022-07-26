# frozen_string_literal: true

require 'pathname'

module RubocopTodoCorrector
  class IgnoreFile
    # @param [String] path
    def initialize(path:)
      @path = path
    end

    # @return [Array<String>]
    def ignored_cop_names
      content.split("\n").map do |line|
        line.sub(/#.+/, '').strip
      end.reject(&:empty?)
    end

    private

    # @return [String]
    def content
      if pathname.exist?
        pathname.read
      else
        ''
      end
    end

    # @return [Pathname]
    def pathname
      @pathname ||= ::Pathname.new(@path)
    end
  end
end
