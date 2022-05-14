# frozen_string_literal: true

module RubocopTodoCorrector
  module Commands
    autoload :Bundle, 'rubocop_todo_corrector/commands/bundle'
    autoload :Generate, 'rubocop_todo_corrector/commands/generate'
    autoload :Pick, 'rubocop_todo_corrector/commands/pick'
  end
end
