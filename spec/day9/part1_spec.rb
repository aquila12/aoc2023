# frozen_string_literal: true

require 'day9/part1'

RSpec.describe Day9::Part1, :aggregate_failures do
  subject(:p1) { described_class.new(example_data.each) }

  context 'with the example data' do
    with_example_data :day9

    describe '.sequence' do
      it 'parses the sequence correctly' do
        expect(p1.sequence(0)).to eq [0, 3, 6, 9, 12, 15]
        expect(p1.sequence(1)).to eq [1, 3, 6, 10, 15, 21]
      end
    end

    describe '.sequence(n).derivative' do
      it 'produces the correct output for the first sequence' do
        s = p1.sequence(0)
        expect(s.derivative).to eq [3, 3, 3, 3, 3]
      end

      it 'produces the correct second derivative for the first sequence' do
        s = p1.sequence(0).derivative
        expect(s.derivative).to eq [0, 0, 0, 0]
      end
    end

    describe '.sequence(n).zeroes?' do
      it 'correctly identifies a sequence of zeroes' do
        s = p1.sequence(0)
        expect(s.zeroes?).to be false
        expect(s.derivative.zeroes?).to be false
        expect(s.derivative.derivative.zeroes?).to be true
      end
    end

    describe '.next_value' do
      it 'predicts the next values correctly for the first sequence' do
        s = p1.sequence(0)
        expect(s.derivative.derivative.next_value).to eq 0
        expect(s.derivative.next_value).to eq 3
        expect(s.next_value).to eq 18
      end

      it 'predicts the next values for the second sequence' do
        s = p1.sequence(1)
        [28, 7, 1, 0].each do |n|
          expect(s.next_value).to eq n
          s = s.derivative
        end
      end

      it 'predicts the next values for the third sequence' do
        s = p1.sequence(2)
        [68, 23, 8, 2, 0].each do |n|
          expect(s.next_value).to eq n
          s = s.derivative
        end
      end
    end

    describe '.sum' do
      it 'sums the next values of all of the sequences' do
        expect(p1.sum).to eq(18 + 28 + 68)
      end
    end
  end

  context 'with the input file' do
    subject(:p1) { described_class.new(input_file.each_line) }

    with_input :day9

    describe '.sum' do
      subject(:sum) { p1.sum }

      it { is_expected.to be_a Numeric }
      it { is_expected.to eq 2008960228 }
    end
  end
end
