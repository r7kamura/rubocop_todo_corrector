# frozen_string_literal: true

require 'pathname'
require 'tempfile'

RSpec.describe RubocopTodoCorrector::Commands::Ignore do
  describe '.call' do
    subject do
      described_class.call(
        cop_name:,
        ignore_file_path:
      )
    end

    let(:cop_name) do
      'Style/StringLiterals'
    end

    let(:ignore_file_path) do
      tempfile.path
    end

    let(:ignore_file_pathname) do
      Pathname.new(ignore_file_path)
    end

    let(:tempfile) do
      Tempfile.new(mode: File::RDWR)
    end

    context 'with non-existent file path' do
      let(:ignore_file_path) do
        '.rubocop_todo_corrector_ignore'
      end

      after do
        FileUtils.rm_f(ignore_file_path)
      end

      it 'appends cop name' do
        subject
        expect(ignore_file_pathname.read).to eq("#{cop_name}\n")
      end
    end

    context 'with existent empty file path' do
      it 'appends cop name' do
        subject
        expect(ignore_file_pathname.read).to eq("#{cop_name}\n")
      end
    end

    context 'with existent non-line-broken file path' do
      before do
        ignore_file_pathname.write(content)
      end

      let(:content) do
        'Style/FrozenStringLiteral'
      end

      it 'appends cop name' do
        subject
        expect(ignore_file_pathname.read).to eq("#{content}\n#{cop_name}\n")
      end
    end

    context 'with existent line-broken file path' do
      before do
        ignore_file_pathname.write(content)
      end

      let(:content) do
        "Style/FrozenStringLiteral\n"
      end

      it 'appends cop name' do
        subject
        expect(ignore_file_pathname.read).to eq("#{content}#{cop_name}\n")
      end
    end

    context 'with duplicated cop name' do
      before do
        ignore_file_pathname.write(content)
      end

      let(:content) do
        'Style/StringLiterals'
      end

      it 'does nothing' do
        subject
        expect(ignore_file_pathname.read).to eq(content)
      end
    end

    context 'with commented-out duplicated cop name' do
      before do
        ignore_file_pathname.write(content)
      end

      let(:content) do
        "# Style/StringLiterals\n"
      end

      it 'appends cop name' do
        subject
        expect(ignore_file_pathname.read).to eq("#{content}#{cop_name}\n")
      end
    end
  end
end
