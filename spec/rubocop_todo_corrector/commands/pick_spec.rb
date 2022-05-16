# frozen_string_literal: true

RSpec.describe RubocopTodoCorrector::Commands::Pick do
  describe '.call' do
    subject do
      described_class.call(
        mode:,
        only_safe:,
        rubocop_todo_path:
      )
    end

    before do
      allow(Kernel).to receive(:abort)
      allow(Kernel).to receive(:puts)
    end

    let(:mode) do
      'first'
    end

    let(:only_safe) do
      true
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

    context 'when no cop found' do
      let(:rubocop_todo_path) do
        'spec/fixtures/dummy_empty_rubocop_todo.yml'
      end

      it 'aborts' do
        subject
        expect(Kernel).to have_received(:abort).with(
          'No cop was picked.'
        )
      end
    end

    context 'with mode first' do
      it 'puts expected cop name' do
        subject
        expect(Kernel).to have_received(:puts).with(
          'Style/StringConcatenation'
        )
      end
    end

    context 'with mode first and only_safe: false' do
      let(:only_safe) do
        false
      end

      it 'puts expected cop name' do
        subject
        expect(Kernel).to have_received(:puts).with(
          'Style/SafeNavigation'
        )
      end
    end

    context 'with mode last' do
      let(:mode) do
        'last'
      end

      it 'puts expected cop name' do
        subject
        expect(Kernel).to have_received(:puts).with(
          'Style/StringLiterals'
        )
      end
    end

    context 'with mode least_occurred' do
      let(:mode) do
        'least_occurred'
      end

      it 'puts expected cop name' do
        subject
        expect(Kernel).to have_received(:puts).with(
          'Style/StringLiterals'
        )
      end
    end

    context 'with mode most_occurred' do
      let(:mode) do
        'most_occurred'
      end

      it 'puts expected cop name' do
        subject
        expect(Kernel).to have_received(:puts).with(
          'Style/StringConcatenation'
        )
      end
    end
  end
end
