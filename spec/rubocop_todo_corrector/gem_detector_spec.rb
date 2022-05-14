# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::GemDetector do
  describe '.call' do
    subject do
      described_class.call(
        configuration_path: 'spec/fixtures/dummy_rubocop.yml'
      )
    end

    it 'returns gem names' do
      is_expected.to eq(
        %w[
          rubocop-rake
          rubocop-rspec
        ]
      )
    end
  end
end
