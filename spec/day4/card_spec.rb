# frozen_string_literal: true

require 'day4/card'

RSpec.describe Day4::Card do
  with_example_data :day4

  context 'with the first example card' do
    subject(:card) { described_class.new(example_data[0]) }

    it 'has the correct five winning numbers' do
      expect(card.winning).to contain_exactly(41, 48, 83, 86, 17)
    end

    it 'has the correct eight numbers you have' do
      expect(card.numbers).to contain_exactly(83, 86, 6, 31, 17, 9, 48, 53)
    end

    it 'has the correct matches' do
      expect(card.matches).to contain_exactly(48, 83, 17, 86)
    end

    it 'scores correctly' do
      expect(card.points).to eq 8
    end
  end

  context 'with the other example cards' do
    # def card(n)
    #   described_class.new(example_data[n - 1])
    # end

    shared_examples 'card has the correct results' do |number:, matches: [], points: 0|
      describe "card #{number}" do
        subject(:card) { described_class.new(example_data[number - 1]) }

        example 'has the correct matches' do
          expect(card.matches).to match_array matches
        end

        example 'scores correctly' do
          expect(card.points).to eq points
        end
      end
    end

    include_examples 'card has the correct results', number: 2, matches: [32, 61], points: 2
    include_examples 'card has the correct results', number: 3, matches: [1, 21], points: 2
    include_examples 'card has the correct results', number: 4, matches: [84], points: 1
    include_examples 'card has the correct results', number: 5
    include_examples 'card has the correct results', number: 6
  end
end
