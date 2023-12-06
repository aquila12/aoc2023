# frozen_string_literal: true

require 'day6/part2'

RSpec.describe Day6::Part2 do
  context 'with the example data', :aggregate_failures do
    subject(:p2) { described_class.new(example_data.each) }

    with_example_data :day6

    describe 'the first race' do
      subject(:race) { p2.race(1) }

      example 'the inputs are correct' do
        expect(race.time).to eq 71530
        expect(race.distance).to eq 940200
      end

      example 'the winning times are correct' do
        expect(race.winning_times).to eq 14..71516
        expect(race.margin).to eq 71503
      end
    end
  end

  context 'with the input file' do
    subject(:p2) { described_class.new(input_file.each_line) }

    with_input :day6

    describe '.margin' do
      subject(:margin) { p2.margin }

      it { is_expected.to be_a Numeric }
      it { is_expected.to eq 35349468 }
    end
  end
end
