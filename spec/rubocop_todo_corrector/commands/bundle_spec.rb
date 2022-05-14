# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::Commands::Bundle do
  describe '.call' do
    subject do
      described_class.call(
        rubocop_configuration_path: 'spec/fixtures/dummy_rubocop.yml',
        gemfile_lock_path: 'spec/fixtures/dummy_gemfile.lock',
        temporary_gemfile_path: 'tmp/Gemfile_rubocop_todo_corrector.rb'
      )
    end

    before do
      allow(Kernel).to receive(:system)
    end

    it 'install gems' do
      subject
      expect(Kernel).to have_received(:system).with(
        { 'BUNDLE_GEMFILE' => 'tmp/Gemfile_rubocop_todo_corrector.rb' },
        'bundle install'
      )
    end
  end
end
