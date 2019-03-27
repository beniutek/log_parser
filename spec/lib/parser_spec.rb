require 'parser'

RSpec.describe Parser do
  let(:file) { "spec/test.log" }

  describe ".parse!" do
    subject { described_class.new(file).parse!.result }

    let(:expected) {{
      "/foo" => {
        unique_count: 3,
        all_count: 4,
        ips: Set.new(["1.1.1.1", "1.1.1.2", "1.1.1.3"]),
      },
      "/bar" => {
        unique_count: 2,
        all_count: 2,
        ips: Set.new(["2.2.2.1", "2.2.2.2"]),
      },
      "/zet" => {
        unique_count: 1,
        all_count: 1,
        ips: Set.new(["3.3.3.1"]),
      },
    }}

    it { is_expected.to eq expected }
  end

  describe "ordered" do
    subject { described_class.new(file).ordered }

    let(:expected) {[
      "/foo 3 unique views",
      "/bar 2 unique views",
      "/zet 1 unique views",
    ]}

    it { is_expected.to match_array(expected) }
  end
end
