# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::Commands::Install do
  describe '#call' do
    subject do
      instance.call
    end

    let(:instance) do
      described_class.new(
        configuration_path: 'spec/fixtures/dummy_rubocop.yml',
        gemfile_lock_path: 'spec/fixtures/dummy_gemfile.lock'
      )
    end

    before do
      allow(Kernel).to receive(:system)
    end

    it 'install gems' do
      subject
      expect(Kernel).to have_received(:system).with(
        'gem install --no-document rubocop:1.29.1 rubocop-rake:0.6.0 rubocop-rspec:2.10.0'
      )
    end
  end
end
