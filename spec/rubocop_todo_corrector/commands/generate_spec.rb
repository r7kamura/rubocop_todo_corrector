# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::Commands::Generate do
  describe '.call' do
    subject do
      described_class.call(
        temporary_gemfile_path: 'tmp/Gemfile_rubocop_todo_corrector.rb'
      )
    end

    before do
      allow(Kernel).to receive(:system)
    end

    it 'generates .rubocop_todo.yml' do
      subject
      expect(Kernel).to have_received(:system).with(
        { 'BUNDLE_GEMFILE' => 'tmp/Gemfile_rubocop_todo_corrector.rb' },
        'bundle exec rubocop --auto-gen-config'
      )
    end
  end
end
