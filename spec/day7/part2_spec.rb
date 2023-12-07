# frozen_string_literal: true

require 'day7/part2'

RSpec.describe Day7::Part2 do
  context 'with the example data', :aggregate_failures do
    subject(:p2) { described_class.new(example_data.each) }

    with_example_data :day7

    describe '.hands' do
      subject(:hands) { p2.hands }

      example 'the hands sort correctly' do
        expect(hands.sort.map(&:to_s)).to eq(%w[32T3K KK677 T55J5 QQQJA KTJJT])
      end
    end

    it 'has the correct score' do
      expect(p2.score).to eq 5905
    end
  end

  example 'a five-of-a-kind has an internal type-score of ten' do
    expect(described_class::Hand.new('55555', 0).type).to eq(10)
  end

  context 'with the input file' do
    subject(:p2) { described_class.new(input_file.each_line) }

    with_input :day7

    describe '.score' do
      subject(:score) { p2.score }

      it { is_expected.to be_a Numeric }
      it { is_expected.to eq 245461700 }
    end
  end
end
