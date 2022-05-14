# frozen_string_literal: true

require 'thor'

module RubocopTodoCorrector
  # Provide CLI sub-commands.
  class Cli < ::Thor
    desc 'bundle', 'Run `bundle install` to install RuboCop related gems.'
    def bundle
      Commands::Bundle.call(
        rubocop_configuration_path: '.rubocop.yml',
        gemfile_lock_path: 'Gemfile.lock',
        temporary_gemfile_path: 'tmp/Gemfile_rubocop_todo_corrector.rb'
      )
    end

    desc 'generate', 'Run `rubocop --auto-gen-config` to generate .rubocop_todo.yml.'
    def generate
      Commands::Generate.call(
        rubocop_todo_path: '.rubocop_todo.yml',
        temporary_gemfile_path: 'tmp/Gemfile_rubocop_todo_corrector.rb'
      )
    end

    desc 'pick', 'Pick an auto-correctable Cop from .rubocop_todo.yml.'
    option(
      :mode,
      default: 'random',
      enum: %w[
        first
        last
        least_occured
        most_occured
        random
      ],
      type: :string
    )
    def pick
      puts Commands::Pick.call(
        mode: options[:mode],
        rubocop_todo_path: '.rubocop_todo.yml'
      )
    end
  end
end
