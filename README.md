# RubocopTodoCorrector

[![test](https://github.com/r7kamura/rubocop_todo_corrector/actions/workflows/test.yml/badge.svg)](https://github.com/r7kamura/rubocop_todo_corrector/actions/workflows/test.yml)
[![Gem Version](https://badge.fury.io/rb/rubocop_todo_corrector.svg)](https://rubygems.org/gems/rubocop_todo_corrector)

Auto-correct offenses defined in .rubocop_todo.yml.

## Installation

Install the gem and add to the application's Gemfile by executing:

```
bundle add rubocop_todo_corrector
```

If bundler is not being used to manage dependencies, install the gem by executing:

```
gem install rubocop_todo_corrector
```

## Usage

```console
$ rubocop_todo_corrector
Commands:
  rubocop_todo_corrector bundle                        # Run `bundle install` to install RuboCop related gems.
  rubocop_todo_corrector clean                         # Remove temporary files.
  rubocop_todo_corrector correct                       # Run `rubocop --auto-correct-all`.
  rubocop_todo_corrector describe --cop-name=COP_NAME  # Output Markdown description for specified cop.
  rubocop_todo_corrector generate                      # Run `rubocop --auto-gen-config` to generate .rubocop_todo.yml.
  rubocop_todo_corrector help [COMMAND]                # Describe available commands or one specific command
  rubocop_todo_corrector pick                          # Output an auto-correctable Cop from .rubocop_todo.yml.
  rubocop_todo_corrector remove --cop-name=COP_NAME    # Remove section with specified cop name from .rubocop_todo.yml.
```

### .rubocop_todo_corrector_ignore

By specifying cop names in `.rubocop_todo_corrector_ignore`, you can exclude them from the selection.

```
Style/StringConcatenation
Style/StringLiterals
```

This is useful, for example, when you find a cop that cannot be autocorrected.
