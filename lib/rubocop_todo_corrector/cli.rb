# frozen_string_literal: true

require 'thor'

module RubocopTodoCorrector
  # Provide CLI sub-commands.
  class Cli < ::Thor
    desc 'install', 'Install gems to run RuboCop on this project.'
    def install
      Commands::Install.call(
        configuration_path: '.rubocop.yml',
        gemfile_lock_path: 'Gemfile.lock'
      )
    end
  end
end
