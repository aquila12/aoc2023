# frozen_string_literal: true

require 'day1/part2'

RSpec.describe Day1::Part2 do
  subject(:p2) { described_class.new }

  let(:example_data) do
    %w[two1nine eightwothree abcone2threexyz xtwone3four
       4nineeightseven2 zoneight234 7pqrstsixteen]
  end

  describe '.calibration_value' do
    it 'meets the given examples', :aggregate_failures do
      expected_results = [29, 83, 13, 24, 42, 14, 76]

      example_data.each_with_index do |s, i|
        expect(p2.calibration_value(s)).to eq(expected_results[i])
      end
    end

    it 'extracts correctly from a line with overlapping words' do
      expect(p2.calibration_value('8fourfouroneightr')).to eq(88)
    end
  end

  describe '.sum' do
    it 'meets the given example' do
      expect(p2.sum(example_data.each)).to eq(281)
    end
  end

  context 'when given an input file' do
    subject(:the_answer) { p2.sum(input_lines) }

    with_input('1/input')

    it { is_expected.to be_a(Numeric) }

    it { is_expected.to eq(55218) }
  end
end
