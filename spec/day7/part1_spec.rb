# frozen_string_literal: true

require 'day7/part1'

RSpec.describe Day7::Part1 do
  context 'with the example data', :aggregate_failures do
    subject(:p1) { described_class.new(example_data.each) }

    with_example_data :day7

    describe '.hands' do
      subject(:hands) { p1.hands }

      example 'there are five hands' do
        expect(hands.length).to eq 5
      end

      example 'the hands sort correctly' do
        expect(hands.sort.map(&:to_s)).to eq(%w[32T3K KTJJT KK677 T55J5 QQQJA])
      end

      example 'the bid amounts are correct' do
        expect(hands.map(&:bid)).to eq([765, 684, 28, 220, 483])
      end
    end

    it 'has the correct score' do
      expect(p1.score).to eq 6440
    end
  end

  context 'with the input file' do
    subject(:p1) { described_class.new(input_file.each_line) }

    with_input :day7

    describe '.score' do
      subject(:score) { p1.score }

      it { is_expected.to be_a Numeric }
      it { is_expected.to eq 247823654 }
    end
  end
end
