# frozen_string_literal: true

require 'day8/part2'

RSpec.describe Day8::Part2, :aggregate_failures do
  subject(:p2) { described_class.new(example_data.each) }

  with_example_data :day8_2a

  context 'with the example' do
    describe '.next_node' do
      example 'it goes through the expected path' do
        expect(p2.node).to eq %w[11A 22A]
        [%w[11B 22B], %w[11Z 22C], %w[11B 22Z], %w[11Z 22B], %w[11B 22C], %w[11Z 22Z]].each do |n|
          expect(p2.next_node).to eq n
        end
        expect { p2.next_node }.to raise_error(StopIteration)
      end
    end

    example '.steps_to_end' do
      expect(p2.steps_to_end).to eq 6
    end
  end

  describe '.factors' do
    example 'it iterates the factors of 72 correctly' do
      expect(p2.factors(72).to_a).to contain_exactly(1, 2, 3, 4, 6, 8, 9, 12, 18, 24, 36, 72)
    end

    example 'it iterates the factors of 1 correctly' do
      expect(p2.factors(1).to_a).to contain_exactly(1)
    end
  end

  describe '.sequence_period' do
    example 'it is the length of the sequence for non-repeating sequences' do
      expect(p2.sequence_period('LRLLRRLR')).to eq 8
    end

    example 'it is the length of the repeated sequence for repeating sequences' do
      expect(p2.sequence_period('LRLRLRLR')).to eq 2
    end
  end

  # context 'with the input file' do
  #   subject(:p2) { described_class.new(input_file.each_line) }

  #   with_input :day8

  #   describe '.steps_to_end' do
  #     subject(:steps_to_end) { p2.steps_to_end }

  #     it { is_expected.to be_a Numeric }
  #     it { is_expected.to eq 17141 }
  #   end
  # end
end
