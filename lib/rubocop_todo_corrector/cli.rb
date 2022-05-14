# frozen_string_literal: true

require 'thor'

module RubocopTodoCorrector
  # Provide CLI sub-commands.
  class Cli < ::Thor
    desc 'bundle', 'Install gems to run RuboCop on this project.'
    def bundle
      Commands::Bundle.call(configuration_path: '.rubocop.yml')
    end
  end
end
