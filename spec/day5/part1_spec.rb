# frozen_string_literal: true

require 'day5/part1'

RSpec.describe Day5::Part1 do
  subject(:p1) { described_class.new }

  with_example_data :day5

  describe '.seeds' do
    context 'with the example data' do
      subject(:seeds) { p1.seeds(example_data[0..0]) }

      it { is_expected.to contain_exactly(79, 14, 55, 13) }
    end
  end

  describe '.maps' do
    context 'with the example maps' do
      subject(:maps) { p1.maps(example_data[3..-1]) }

      it 'has seven maps' do
        expect(maps.length).to eq 7
      end

      it 'has the correct input types' do
        expect(maps.keys).to contain_exactly(
          :seed, :soil, :fertilizer, :water, :light, :temperature, :humidity
        )
      end
    end
  end
end

# describe 'the seeds that need to be planted'
# describe 'the maps'
