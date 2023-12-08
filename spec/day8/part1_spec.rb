# frozen_string_literal: true

require 'day8/part1'

RSpec.describe Day8::Part1, :aggregate_failures do
  subject(:p1) { described_class.new(example_data.each) }

  context 'with the first example' do
    with_example_data :day8_1a

    describe '.next_direction' do
      example 'it reads the instructions in a loop' do
        expect(p1.next_direction).to eq 'R'
        expect(p1.next_direction).to eq 'L'
        expect(p1.next_direction).to eq 'R'
        expect(p1.next_direction).to eq 'L'
        expect(p1.next_direction).to eq 'R'
      end
    end

    describe '.next_node' do
      example 'it goes through the expected path' do
        expect(p1.node).to eq 'AAA'
        expect(p1.next_node).to eq 'CCC'
        expect(p1.next_node).to eq 'ZZZ'
        expect { p1.next_node }.to raise_error(StopIteration)
      end
    end

    example '.steps_to_end' do
      expect(p1.steps_to_end).to eq 2
    end
  end

  context 'with the second example' do
    with_example_data :day8_1b

    describe '.next_direction' do
      example 'it reads the instructions in a loop' do
        expect(p1.next_direction).to eq 'L'
        expect(p1.next_direction).to eq 'L'
        expect(p1.next_direction).to eq 'R'
        expect(p1.next_direction).to eq 'L'
        expect(p1.next_direction).to eq 'L'
      end
    end

    describe '.next_node' do
      example 'it goes through the expected path' do
        expect(p1.node).to eq 'AAA'
        %w[BBB AAA BBB AAA BBB ZZZ].each do |n|
          expect(p1.next_node).to eq(n)
        end
      end
    end

    example '.steps_to_end' do
      expect(p1.steps_to_end).to eq 6
    end
  end
end
