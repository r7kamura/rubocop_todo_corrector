# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::Commands::Clean do
  describe '.call' do
    subject do
      described_class.call(
        temporary_gemfile_path: 'tmp/Gemfile_rubocop_todo_corrector.rb'
      )
    end

    before do
      allow(FileUtils).to receive(:rm_f)
    end

    it 'calls FileUtils.rm_f with expected paths' do
      subject
      expect(FileUtils).to have_received(:rm_f).with(
        %w[
          tmp/Gemfile_rubocop_todo_corrector.rb
          tmp/Gemfile_rubocop_todo_corrector.rb.lock
        ]
      )
    end
  end
end
