# frozen_string_literal: true

require 'day5/part2'

RSpec.describe Day5::Part2 do
  context 'with the example data' do
    subject(:p1) { described_class.new(example_data.each) }

    with_example_data :day5

    describe '.seeds' do
      subject(:seeds) { p1.seeds }

      it { is_expected.to contain_exactly((79..92), (55..67)) }
    end

    describe '.lowest' do
      subject(:lowest) { p1.lowest }

      it { is_expected.to eq 46 }
    end
  end

  context 'with the input file' do
    subject(:p1) { described_class.new(input_file.each_line) }

    with_input :day5

    describe '.lowest' do
      subject(:lowest) { p1.lowest }

      it { is_expected.to be_a Numeric }
      it { is_expected.to eq 37384986 }
    end
  end
end
