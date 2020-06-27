require 'writer'

RSpec.describe Writer do
  let(:args) { ["log.log"] }
  let(:arg_parser) { ArgumentParser.new(args) }
  let(:ordered) {[
    "/foo 3 unique views",
    "/bar 2 unique views",
    "/zet 2 unique views",
  ]}

  let(:result) {{
    "/foo" => {
      unique_count: 3,
      all_count: 4,
      ips: [],
    },
    "/bar" => {
      unique_count: 2,
      all_count: 3,
      ips: [],
    },
    "/zet" => {
      unique_count: 2,
      all_count: 4,
      ips: [],
    }
  }}

  let(:parsed_log) {
    double('parsed_log').tap do |log|
      allow(log).to receive(:ordered).and_return(ordered)
      allow(log).to receive(:result).and_return(result)
    end
  }

  describe ".write" do
    describe "when no options were passed" do
      it "sends the lines to STDOUT" do
        expect(STDOUT).to receive(:puts).with("/foo 3 unique views")
        expect(STDOUT).to receive(:puts).with("/bar 2 unique views")
        expect(STDOUT).to receive(:puts).with("/zet 2 unique views")

        described_class.new(parsed_log, arg_parser).write
      end
    end

    describe "when some options were passed" do
      let(:file) { double('file') }

      before do
        allow(File).to receive(:open).and_yield(file)
        allow(file).to receive(:write)
      end

      describe "when create csv option was passed" do
        let(:filename) { "foo.csv" }
        let(:args) { ["-csv", filename, "log.log"] }

        it "creates a csv file" do
          expect(File).to receive(:open).with(filename, 'w')
          expect(file).to receive(:write).with("/foo,3,4\n")
          expect(file).to receive(:write).with("/bar,2,3\n")
          expect(file).to receive(:write).with("/zet,2,4\n")

          described_class.new(parsed_log, arg_parser).write
        end
      end

      describe "when create csv option was passed" do
        let(:filename) { "foo.txt" }
        let(:args) { ["-f", filename, "log.log"] }

        it "creates a csv file" do
          expect(File).to receive(:open).with(filename, 'w')
          expect(file).to receive(:write).with("/foo 3 unique views\n")
          expect(file).to receive(:write).with("/bar 2 unique views\n")
          expect(file).to receive(:write).with("/zet 2 unique views\n")

          described_class.new(parsed_log, arg_parser).write
        end
      end
    end
  end
end
