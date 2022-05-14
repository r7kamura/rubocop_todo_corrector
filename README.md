# RubocopTodoCorrector

[![test](https://github.com/r7kamura/rubocop_todo_corrector/actions/workflows/test.yml/badge.svg)](https://github.com/r7kamura/rubocop_todo_corrector/actions/workflows/test.yml)

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
$ rubocop_todo_corrector --help
Commands:
  rubocop_todo_corrector bundle          # Run `bundle install` to install RuboCop related gems.
  rubocop_todo_corrector generate        # Run `rubocop --auto-gen-config` to generate .rubocop_todo.yml.
  rubocop_todo_corrector help [COMMAND]  # Describe available commands or one specific command
  rubocop_todo_corrector pick            # Pick an auto-correctable Cop from .rubocop_todo.yml.
```

### bundle

```console
$ rubocop_todo_corrector help bundle
Usage:
  rubocop_todo_corrector bundle

Run `bundle install` to install RuboCop related gems.
```

### generate

```console
$ rubocop_todo_corrector help generate
Usage:
  rubocop_todo_corrector generate

Run `rubocop --auto-gen-config` to generate .rubocop_todo.yml.
```

### pick

```console
$ rubocop_todo_corrector help pick
Usage:
  rubocop_todo_corrector pick

Options:
  [--mode=MODE]
                 # Default: random
                 # Possible values: first, last, least_occured, most_occured, random

Pick an auto-correctable Cop from .rubocop_todo.yml.
```
