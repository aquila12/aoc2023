# frozen_string_literal: true

require 'day2/part2'

RSpec.describe Day2::Part2 do
  subject(:p2) { described_class.new }

  let(:example_data) do
    <<~EXAMPLE
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    EXAMPLE
  end

  def game(example_number)
    Day2::Game.new(example_data.lines[example_number - 1])
  end

  describe 'Game.smallest_set' do
    it 'matches the examples given', :aggregate_failures do
      expect(game(1).smallest_set).to match(red: 4, green: 2, blue: 6)
      expect(game(2).smallest_set).to match(red: 1, green: 3, blue: 4)
      expect(game(3).smallest_set).to match(red: 20, green: 13, blue: 6)
      expect(game(4).smallest_set).to match(red: 14, green: 3, blue: 15)
      expect(game(5).smallest_set).to match(red: 6, green: 3, blue: 2)
    end
  end

  describe 'Set.power' do
    it 'matches the examples given', :aggregate_failures do
      expect(game(1).smallest_set.power).to eq 48
      expect(game(2).smallest_set.power).to eq 12
      expect(game(3).smallest_set.power).to eq 1560
      expect(game(4).smallest_set.power).to eq 630
      expect(game(5).smallest_set.power).to eq 36
    end
  end

  context 'when given an input file' do
    subject(:the_answer) { p2.sum(input_lines) }

    with_input('2/input')

    it { is_expected.to be_a(Numeric) }
  end
end
