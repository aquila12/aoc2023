# frozen_string_literal: true

require 'day3/part2'

RSpec.describe Day3::Part2 do
  subject(:p2) { described_class.new }

  with_example_data :day3
  with_input :day3

  describe '.sum' do
    subject(:sum) do
      p2.sum(input)
    end

    context 'with the example data' do
      let(:input) { example_data.each }

      it { is_expected.to eq 467835 }
    end

    context 'with the input file' do
      let(:input) { input_lines }

      it { is_expected.to eq 84883664 }
    end
  end
end
