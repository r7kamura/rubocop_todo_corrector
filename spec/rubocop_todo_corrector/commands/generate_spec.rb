# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::Commands::Generate do
  describe '.call' do
    subject do
      described_class.call(
        rubocop_todo_path: rubocop_todo_path,
        temporary_gemfile_path: 'tmp/Gemfile_rubocop_todo_corrector.rb'
      )
    end

    before do
      allow(Kernel).to receive(:system)
    end

    let(:rubocop_todo_path) do
      'spec/fixtures/rubocop_todo.yml'
    end

    context 'without existent .rubocop_todo.yml' do
      let(:rubocop_todo_path) do
        'spec/fixtures/non_existent_rubocop_todo_path.yml'
      end

      it 'runs rubocop with default options' do
        subject
        expect(Kernel).to have_received(:system).with(
          { 'BUNDLE_GEMFILE' => 'tmp/Gemfile_rubocop_todo_corrector.rb' },
          'bundle exec rubocop --auto-gen-config'
        )
      end
    end

    context 'with existent .rubocop_todo.yml' do
      it 'runs rubocop with the same options' do
        subject
        expect(Kernel).to have_received(:system).with(
          { 'BUNDLE_GEMFILE' => 'tmp/Gemfile_rubocop_todo_corrector.rb' },
          'bundle exec rubocop --auto-gen-config --exclude-limit 9999 --no-offense-counts --no-auto-gen-timestamp'
        )
      end
    end
  end
end
