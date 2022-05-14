# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::GemVersionDetector do
  describe '.call' do
    subject do
      described_class.call(
        gemfile_lock_path: 'spec/fixtures/dummy_gemfile.lock',
        gem_name: 'rubocop-rspec'
      )
    end

    it 'returns gem version' do
      is_expected.to eq(
        '2.10.0'
      )
    end
  end
end
