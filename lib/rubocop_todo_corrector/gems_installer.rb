# frozen_string_literal: true

module RubocopTodoCorrector
  class GemsInstaller
    class << self
      # @param [Hash] gem_specifications
      def call(gem_specifications:)
        new(gem_specifications: gem_specifications).call
      end
    end

    def initialize(gem_specifications:)
      @gem_specifications = gem_specifications
    end

    def call
      ::Kernel.system(gem_install_command)
    end

    private

    # @return [String]
    def gem_install_command
      "gem install --no-document #{gem_install_arguments}"
    end

    # @return [String]
    def gem_install_arguments
      @gem_specifications.map do |gem_specification|
        gem_specification.values_at(
          :gem_name,
          :gem_version
        ).join(':')
      end.join(' ')
    end
  end
end
