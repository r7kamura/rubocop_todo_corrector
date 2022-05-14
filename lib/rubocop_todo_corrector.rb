# frozen_string_literal: true

require_relative 'rubocop_todo_corrector/version'

module RubocopTodoCorrector
  autoload :BundleInstaller, 'rubocop_todo_corrector/bundle_installer'
  autoload :Cli, 'rubocop_todo_corrector/cli'
  autoload :Commands, 'rubocop_todo_corrector/commands'
  autoload :GemNamesDetector, 'rubocop_todo_corrector/gem_names_detector'
  autoload :GemVersionDetector, 'rubocop_todo_corrector/gem_version_detector'
end
