# frozen_string_literal: true

require 'day4/part2'

RSpec.describe Day4::Part2 do
  subject(:p2) { described_class.new }

  with_example_data :day4

  describe '.sum' do
    context 'with example data' do
      subject(:sum) { p2.sum(example_data.each) }

      it { is_expected.to eq 30 }
    end

    context 'when given an input file' do
      subject(:sum) { p2.sum(input_lines) }

      with_input :day4

      it { is_expected.to be_a Numeric }
      it { is_expected.to eq 5489600 }
    end
  end
end
