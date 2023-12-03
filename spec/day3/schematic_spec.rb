# frozen_string_literal: true

require 'day3/schematic'

RSpec.describe Day3::Schematic do
  with_example_data :day3
  with_input :day3

  describe '.numbers' do
    subject(:numbers) { schematic.send :numbers }

    context 'with the example data' do
      let(:schematic) { described_class.new(example_data) }

      it 'contains ten numbers' do
        expect(numbers.count).to eq 10
      end

      it { is_expected.to include match(num: 114, row: 0, rows: (-1..1), cols: (4..8)) }
      it { is_expected.to include match(num: 664, row: 9, rows: (8..10), cols: (0..4)) }
    end
  end

  describe '.symbols' do
    subject(:symbols) { schematic.send :symbols }

    context 'with the example data' do
      let(:schematic) { described_class.new(example_data) }

      it 'contains six symbols' do
        expect(symbols.count).to eq(6)
      end

      it { is_expected.to include match(sym: '*', row: 1, col: 3) }
      it { is_expected.to include match(sym: '$', row: 8, col: 3) }
    end
  end

  describe '.part_numbers' do
    subject(:part_numbers) { schematic.part_numbers }

    context 'with the example data' do
      let(:schematic) { described_class.new(example_data) }

      it { is_expected.not_to include(114, 58) }
      it { is_expected.to contain_exactly(467, 35, 633, 617, 592, 755, 664, 598) }
    end

    context 'with the input file' do
      let(:schematic) { described_class.new(input_lines) }

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

  describe '.gears' do
    subject(:gears) { schematic.gears }

    context 'with the example data' do
      let(:schematic) { described_class.new(example_data) }

      it 'contains two gears' do
        expect(gears.count).to eq 2
      end

      it { is_expected.to include match(numbers: contain_exactly(467, 35), ratio: 16345) }
      it { is_expected.to include match(numbers: contain_exactly(755, 598), ratio: 451490) }
    end
  end
end
