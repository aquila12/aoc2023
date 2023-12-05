# frozen_string_literal: true

require 'day5/part1'

RSpec.describe Day5::Part1 do
  context 'with the example data' do
    subject(:p1) { described_class.new(example_data.each) }

    with_example_data :day5

    describe '.seeds' do
      subject(:seeds) { p1.seeds }

      it { is_expected.to contain_exactly(79, 14, 55, 13) }
    end

    describe '.maps' do
      subject(:maps) { p1.maps }

      it 'has seven maps' do
        expect(maps.length).to eq 7
      end

      it 'has the correct input types' do
        expected_inputs = %w[seed soil fertilizer water light temperature humidity]
        expect(maps.keys).to match_array(expected_inputs)
      end

      it 'has the correct output types' do
        expected_outputs = %w[soil fertilizer water light temperature humidity location]
        expect(maps.values.map(&:output)).to match_array(expected_outputs)
      end
    end

    describe '.map' do
      [
        { seed: 79, soil: 81, fertilizer: 81, water: 81, light: 74, temperature: 78, humidity: 78, location: 82 },
        { seed: 14, soil: 14, fertilizer: 53, water: 49, light: 42, temperature: 42, humidity: 43, location: 43 },
        { seed: 55, soil: 57, fertilizer: 57, water: 53, light: 46, temperature: 82, humidity: 82, location: 86 },
        { seed: 13, soil: 13, fertilizer: 52, water: 41, light: 34, temperature: 34, humidity: 35, location: 35 }
      ].each do |expected_sequence|
        seed_number = expected_sequence[:seed]

        expected_sequence.each do |target_type, target_value|
          next if target_type == :seed

          it "produces the expected #{target_type} value for seed #{seed_number}" do
            expect(p1.map(seed_number, :seed, target_type)).to eq(target_value)
          end
        end
      end
    end

    describe '.lowest' do
      subject(:lowest) { p1.lowest }

      it { is_expected.to eq 35 }
    end
  end

  context 'with the input file' do
    subject(:p1) { described_class.new(input_file.each_line) }

    with_input :day5

    describe '.lowest' do
      subject(:lowest) { p1.lowest }

      it { is_expected.to be_a Numeric }
    end
  end
end
