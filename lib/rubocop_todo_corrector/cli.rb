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

    desc 'correct', 'Run `rubocop --auto-correct(-all)`.'
    option(
      :only_safe,
      default: true,
      type: :boolean
    )
    def correct
      Commands::Correct.call(
        only_safe: options[:only_safe],
        temporary_gemfile_path: 'tmp/Gemfile_rubocop_todo_corrector.rb'
      )
    end

    desc 'describe', 'Output Markdown description for specified cop.'
    option(
      :cop_name,
      type: :string,
      required: true
    )
    def describe
      Commands::Describe.call(
        cop_name: options[:cop_name],
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

    desc 'pick', 'Output an auto-correctable Cop from .rubocop_todo.yml.'
    option(
      :mode,
      default: 'random',
      enum: %w[
        first
        last
        least_occurred
        most_occurred
        random
      ],
      type: :string
    )
    option(
      :only_safe,
      default: true,
      type: :boolean
    )
    def pick
      Commands::Pick.call(
        mode: options[:mode],
        only_safe: options[:only_safe],
        rubocop_todo_path: '.rubocop_todo.yml'
      )
    end

    desc 'remove', 'Remove section with specified cop name from .rubocop_todo.yml.'
    option(
      :cop_name,
      type: :string,
      required: true
    )
    def remove
      Commands::Remove.call(
        cop_name: options[:cop_name],
        rubocop_todo_path: '.rubocop_todo.yml'
      )
    end
  end
end
