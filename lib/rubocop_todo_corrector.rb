# frozen_string_literal: true

require_relative 'rubocop_todo_corrector/version'

module RubocopTodoCorrector
  autoload :BundleInstaller, 'rubocop_todo_corrector/bundle_installer'
  autoload :Cli, 'rubocop_todo_corrector/cli'
  autoload :Commands, 'rubocop_todo_corrector/commands'
  autoload :CopDocumentParser, 'rubocop_todo_corrector/cop_document_parser'
  autoload :CopSourceDetector, 'rubocop_todo_corrector/cop_source_detector'
  autoload :CopUrlFinder, 'rubocop_todo_corrector/cop_url_finder'
  autoload :DescriptionRenderer, 'rubocop_todo_corrector/description_renderer'
  autoload :GemNamesDetector, 'rubocop_todo_corrector/gem_names_detector'
  autoload :GemVersionDetector, 'rubocop_todo_corrector/gem_version_detector'
  autoload :IgnoreFile, 'rubocop_todo_corrector/ignore_file'
  autoload :RubocopTodoParser, 'rubocop_todo_corrector/rubocop_todo_parser'
  autoload :RubocopTodoSectionParser, 'rubocop_todo_corrector/rubocop_todo_section_parser'
end
