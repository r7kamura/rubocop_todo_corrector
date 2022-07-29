# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::Commands::Generate do
  describe '.call' do
    subject do
      described_class.call(
        rubocop_todo_path:,
        temporary_gemfile_path: 'tmp/Gemfile_rubocop_todo_corrector.rb'
      )
    end

    before do
      allow(Kernel).to receive(:system)
    end

    let(:rubocop_todo_path) do
      'spec/fixtures/dummy_rubocop_todo.yml'
    end

    context 'with valid condition' do
      it 'runs bundle exec rubocop --regenerate-todo' do
        subject
        expect(Kernel).to have_received(:system).with(
          { 'BUNDLE_GEMFILE' => 'tmp/Gemfile_rubocop_todo_corrector.rb' },
          'bundle exec rubocop --regenerate-todo'
        )
      end
    end
  end
end
