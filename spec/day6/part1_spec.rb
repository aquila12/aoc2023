# frozen_string_literal: true

require 'day6/part1'

RSpec.describe Day6::Part1 do
  context 'with the example data', :aggregate_failures do
    subject(:p1) { described_class.new(example_data.each) }

    with_example_data :day6

    describe 'the first race' do
      subject(:race) { p1.race(1) }

      example 'the inputs are correct' do
        expect(race.time).to eq 7
        expect(race.distance).to eq 9
      end

      example 'the winning times are correct' do
        expect(race.winning_times).to eq 2..5
        expect(race.margin).to eq 4
      end
    end

    describe 'the second race' do
      subject(:race) { p1.race(2) }

      example 'the winning times are correct' do
        expect(race.winning_times).to eq 4..11
        expect(race.margin).to eq 8
      end
    end

    describe 'the third race' do
      subject(:race) { p1.race(3) }

      example 'the winning times are correct' do
        expect(race.winning_times).to eq 11..19
        expect(race.margin).to eq 9
      end
    end

    it 'produces the correct product' do
      expect(p1.product).to eq 288
    end
  end

  context 'with the input file' do
    subject(:p1) { described_class.new(input_file.each_line) }

    with_input :day6

    describe '.product' do
      subject(:product) { p1.product }

      it { is_expected.to be_a Numeric }
      it { is_expected.to eq 1710720 }
    end
  end
end
