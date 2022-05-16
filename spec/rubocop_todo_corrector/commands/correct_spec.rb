# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::Commands::Correct do
  describe '.call' do
    subject do
      described_class.call(
        only_safe:,
        temporary_gemfile_path: 'tmp/Gemfile_rubocop_todo_corrector.rb'
      )
    end

    before do
      allow(Kernel).to receive(:system)
    end

    let(:only_safe) do
      true
    end

    context 'with valid condition' do
      it 'runs rubocop --auto-correct' do
        subject
        expect(Kernel).to have_received(:system).with(
          { 'BUNDLE_GEMFILE' => 'tmp/Gemfile_rubocop_todo_corrector.rb' },
          'bundle exec rubocop --auto-correct'
        )
      end
    end

    context 'with only_safe: false' do
      let(:only_safe) do
        false
      end

      it 'runs rubocop --auto-correct-all' do
        subject
        expect(Kernel).to have_received(:system).with(
          { 'BUNDLE_GEMFILE' => 'tmp/Gemfile_rubocop_todo_corrector.rb' },
          'bundle exec rubocop --auto-correct-all'
        )
      end
    end
  end
end
