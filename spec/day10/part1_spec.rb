# frozen_string_literal: true

require 'day10/part1'

RSpec.describe Day10::Part1, :aggregate_failures do
  subject(:p1) { described_class.new(example_data.each) }

  context 'with the first example' do
    with_example_data :day10_1a

    describe '.cell' do
      example 'it reads cells in row, column order' do # rubocop:disable RSpec/ExampleLength
        expect(p1.cell(2, 2)).to eq 0
        expect(p1.cell(2, 3)).to eq 4
        expect(p1.cell(2, 4)).to eq 5
        expect(p1.cell(3, 4)).to eq 3
        expect(p1.cell(4, 4)).to eq 1
        expect(p1.cell(4, 2)).to eq 2
      end
    end

    describe '.start_point' do
      it 'is at row 2, column 2' do
        expect(p1.start_point).to eq [2, 2]
      end
    end

    describe '.farthest_point' do
      it 'is at row 4, column 4' do
        expect(p1.farthest_point).to eq [4, 4]
      end
    end

    describe '.farthest_distance' do
      it 'is 4 steps from the start' do
        expect(p1.farthest_distance).to eq 4
      end
    end
  end

  context 'with the second example' do
    with_example_data :day10_1b

    describe '.cell' do
      example 'it reads cells in row, column order' do
        expect(p1.cell(2, 1)).to be_nil
      end
    end

    describe '.start_point' do
      it 'is at row 3, column 1' do
        expect(p1.start_point).to eq [3, 1]
      end
    end

    describe '.farthest_point' do
      it 'is at row 3, column 5' do
        expect(p1.farthest_point).to eq [3, 5]
      end
    end

    describe '.farthest_distance' do
      it 'is 8 steps from the start' do
        expect(p1.farthest_distance).to eq 8
      end
    end
  end
end
