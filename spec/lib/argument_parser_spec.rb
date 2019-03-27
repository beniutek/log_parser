require 'argument_parser'

RSpec.describe ArgumentParser do
  let(:args) { ['foo.log'] }
  let(:filename) { 'foo' }

  describe ".initialize" do
    describe "no args" do
      it "raises an error" do
        expect { ArgumentParser.new }.to raise_error(ArgumentParser::NoArgumentsError)
      end
    end
  end

  describe ".no_options?" do
    subject { described_class.new(args).no_options? }

    describe 'when no options are passed' do
      it { is_expected.to eq true }
    end

    describe 'when some options are passed' do
      let(:args) { ['-f', 'file.txt', 'foo.log'] }
      it { is_expected.to eq false }
    end
  end

  describe ".print_to_csv?" do
    subject { described_class.new(args).print_to_csv? }

    describe "when this option doesn't exist" do
      it { is_expected.to eq false }
    end

    describe "when this option does exist" do
      let(:args) { ['-csv', 'file.csv', 'foo.log'] }
      it { is_expected.to eq true }
    end
  end

  describe ".print_to_file?" do
    subject { described_class.new(args).print_to_file? }

    describe "when this option doesn't exist" do
      it { is_expected.to eq false }
    end

    describe "when this option does exist" do
      let(:args) { ['-f', 'file.txt', 'foo.log'] }
      it { is_expected.to eq true }
    end
  end

  describe '.csv_filename' do
    subject { described_class.new(args).csv_filename }
    let(:args) { ['-csv', filename, 'foo.log'] }

    it { is_expected.to eq filename }
  end

  describe '.file_filename' do
    subject { described_class.new(args).file_filename }
    let(:args) { ['-f', filename, 'foo.log'] }

    it { is_expected.to eq filename }
  end
end
