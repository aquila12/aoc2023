# frozen_string_literal: true

require 'day2/part2'

RSpec.describe Day2::Part2 do
  subject(:p2) { described_class.new }

  with_example_data :day2

  def game(example_number)
    Day2::Game.new(example_data[example_number - 1])
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

    it { is_expected.to eq 60948 }

    example 'every game has nonzero positive power' do
      expect(p2.powers(input_lines)).to all(be_positive)
    end

    example 'every game includes exactly three colours' do
      have_three_colours = satisfy do |g|
        g.smallest_set.length == 3
      end

      expect(p2.games(input_lines)).to all have_three_colours
    end
  end
end
