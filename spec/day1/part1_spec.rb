# frozen_string_literal: true

require 'day1/part1'

RSpec.describe Day1::Part1 do
  subject(:p1) { described_class.new }

  let(:example_data) { %w[1abc2 pqr3stu8vwx a1b2c3d4e5f treb7uchet] }

  describe '.calibration_value' do
    it 'meets the given examples', :aggregate_failures do
      expected_results = [12, 38, 15, 77]

      example_data.each_with_index do |s, i|
        expect(p1.calibration_value(s)).to eq(expected_results[i])
      end
    end
  end

  describe '.sum' do
    it 'meets the given example' do
      expect(p1.sum(example_data.each)).to eq(142)
    end
  end

  context 'when given an input file' do
    subject(:the_answer) { p1.sum(input_lines) }

    with_input(:day1)

    it { is_expected.to be_a(Numeric) }

    it { is_expected.to eq(54951) }
  end
end
