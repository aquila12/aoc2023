# frozen_string_literal: true

require 'day4/part1'

RSpec.describe Day4::Part1 do
  subject(:p1) { described_class.new }

  with_example_data :day4
  with_input :day4

  describe '.sum' do
    context 'with example data' do
      subject(:sum) { p1.sum(example_data.each) }

      it { is_expected.to eq 13 }
    end

    context 'when given an input file' do
      subject(:sum) { p1.sum(input_lines) }

      it { is_expected.to be_a Numeric }
    end
  end
end
