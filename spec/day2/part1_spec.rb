# frozen_string_literal: true

require 'day2/part1'

RSpec.describe Day2::Part1 do
  subject(:p1) { described_class.new }

  with_example_data :day2

  describe 'Game.cube_sets' do
    context 'when parsing the first game' do
      subject(:cube_sets) do
        Day2::Game.new(line).cube_sets
      end

      let(:line) { example_data.first }

      it { is_expected.to be_an Array }
      it { is_expected.to all(be_a Hash) }

      it 'describes the sets correctly', :aggregate_failures do
        expect(cube_sets[0]).to match(blue: 3, red: 4)
        expect(cube_sets[1]).to match(red: 1, green: 2, blue: 6)
        expect(cube_sets[2]).to match(green: 2)
      end
    end
  end

  describe '.possible_games' do
    context 'with the example data' do
      subject(:possible_games) { p1.possible_games(example_data) }

      it { is_expected.to be_an Enumerable }
      it { is_expected.to contain_exactly(1, 2, 5) }
    end
  end

  describe '.sum' do
    context 'with the example data' do
      subject(:sum) { p1.sum(example_data) }

      it { is_expected.to eq 8 }
    end
  end

  context 'when given an input file' do
    subject(:the_answer) { p1.sum(input_lines) }

    with_input(:day2)

    it { is_expected.to be_a(Numeric) }

    it { is_expected.to eq 2169 }
  end
end
