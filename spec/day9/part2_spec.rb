# frozen_string_literal: true

require 'day9/part2'

RSpec.describe Day9::Part2, :aggregate_failures do
  subject(:p1) { described_class.new(example_data.each) }

  context 'with the example data' do
    with_example_data :day9

    describe '.previous_value' do
      it 'predicts the previous values for the third sequence' do
        s = p1.sequence(2)
        [5, 5, -2, 2, 0].each do |n|
          expect(s.previous_value).to eq n
          s = s.derivative
        end
      end
    end

    describe '.sum' do
      it 'sums the previous values of all of the sequences' do
        expect(p1.sum).to eq(5 + -3 + 0)
      end
    end
  end

  context 'with the input file' do
    subject(:p1) { described_class.new(input_file.each_line) }

    with_input :day9

    describe '.sum' do
      subject(:sum) { p1.sum }

      it { is_expected.to be_a Numeric }
      it { is_expected.to eq 1097 }
    end
  end
end
