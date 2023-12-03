# frozen_string_literal: true

require 'day3/part1'

RSpec.describe Day3::Part1 do
  subject(:p1) { described_class.new }

  with_example_data :day3
  with_input :day3

  describe '.part_numbers' do
    subject(:part_numbers) do
      p1.part_numbers(input)
    end

    context 'with the example data' do
      let(:input) { example_data.each }

      it { is_expected.not_to include(114, 58) }
      it { is_expected.to contain_exactly(467, 35, 633, 617, 592, 755, 664, 598) }
    end

    context 'with the input file' do
      subject(:input) { input_lines }

      example 'it includes numbers with a symbol below' do
        expect(part_numbers).to include(31, 669, 964, 363, 224, 706)
      end

      example 'it includes numbers with a symbol above' do
        expect(part_numbers).to include(472, 135, 629, 791, 523)
      end

      example 'it includes numbers with a symbol to the left' do
        expect(part_numbers).to include(82, 742, 232, 997, 848)
      end

      example 'it includes numbers with a symbol to the right' do
        expect(part_numbers).to include(80, 46, 102)
      end

      example 'it includes numbers with a symbol between them' do
        expect(part_numbers).to include(738, 596, 341, 360)
      end

      example 'it includes numbers with a symbol diagonally adjacent' do
        expect(part_numbers).to include(875, 914, 817, 266)
      end
    end
  end

  describe '.sum' do
    it 'sums the example data to 4361' do
      expect(p1.sum(example_data.each)).to eq 4361
    end
  end

  context 'when given an input file' do
    subject(:the_answer) { p1.sum(input_lines) }

    it { is_expected.to be_a Numeric }
    it { is_expected.to eq 537732 }
  end
end
