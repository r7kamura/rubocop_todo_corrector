# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::Commands::Pick do
  describe '.call' do
    subject do
      described_class.call(
        mode: mode,
        rubocop_todo_path: rubocop_todo_path
      )
    end

    let(:mode) do
      'first'
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

    context 'with mode first' do
      it 'returns cop name' do
        is_expected.to eq(
          'Style/StringConcatenation'
        )
      end
    end

    context 'with mode last' do
      let(:mode) do
        'last'
      end

      it 'returns cop name' do
        is_expected.to eq(
          'Style/StringLiterals'
        )
      end
    end

    context 'with mode least_occured' do
      let(:mode) do
        'least_occured'
      end

      it 'returns cop name' do
        is_expected.to eq(
          'Style/StringLiterals'
        )
      end
    end

    context 'with mode most_occured' do
      let(:mode) do
        'most_occured'
      end

      it 'returns cop name' do
        is_expected.to eq(
          'Style/StringConcatenation'
        )
      end
    end
  end
end
