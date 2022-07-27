# frozen_string_literal: true

require 'pathname'

module RubocopTodoCorrector
  class IgnoreFile
    # @param [String] path
    def initialize(path:)
      @path = path
    end

    # @param [String] cop_name
    def append_cop_name(cop_name)
      return if include?(cop_name)

      appendix = "#{cop_name}\n"
      appendix.prepend("\n") if !content.empty? && !content.end_with?("\n")
      pathname.write("#{content}#{appendix}")
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

    # @param [String] cop_name
    # @return [Boolean]
    def include?(cop_name)
      ignored_cop_names.include?(cop_name)
    end

    # @return [Pathname]
    def pathname
      @pathname ||= ::Pathname.new(@path)
    end
  end
end
