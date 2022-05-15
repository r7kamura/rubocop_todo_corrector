# frozen_string_literal: true

module RubocopTodoCorrector
  module Commands
    autoload :Bundle, 'rubocop_todo_corrector/commands/bundle'
    autoload :Correct, 'rubocop_todo_corrector/commands/correct'
    autoload :Describe, 'rubocop_todo_corrector/commands/describe'
    autoload :Generate, 'rubocop_todo_corrector/commands/generate'
    autoload :Pick, 'rubocop_todo_corrector/commands/pick'
    autoload :Remove, 'rubocop_todo_corrector/commands/remove'
  end
end
