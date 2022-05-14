# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::Commands::Pick do
  describe '.call' do
    subject do
      described_class.call(
        rubocop_todo_path: rubocop_todo_path
      )
    end

    let(:rubocop_todo_path) do
      'spec/fixtures/dummy_rubocop_todo.yml'
    end

    context 'without existent .rubocop_todo.yml' do
      let(:rubocop_todo_path) do
        'spec/fixtures/non_existent_rubocop_todo_path.yml'
      end

      it 'raises error' do
        expect { subject }.to raise_error(RuntimeError)
      end
    end

    context 'with valid condition' do
      it 'returns cop name' do
        is_expected.to eq(
          'Style/StringConcatenation'
        )
      end
    end
  end
end
