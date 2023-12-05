# frozen_string_literal: true

require 'day3/part1'

RSpec.describe Day3::Part1 do
  subject(:p1) { described_class.new }

  with_example_data :day3

  describe '.sum' do
    it 'sums the example data to 4361' do
      expect(p1.sum(example_data.each)).to eq 4361
    end
  end

  context 'when given an input file' do
    subject(:the_answer) { p1.sum(input_lines) }

    with_input :day3

    it { is_expected.to be_a Numeric }
    it { is_expected.to eq 537732 }
  end
end
