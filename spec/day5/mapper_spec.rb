# frozen_string_literal: true

require 'day5/mapper'

RSpec.describe Day5::Mapper do
  subject(:mapper) { described_class.new(:test_type, input) }

  with_example_data :day5

  let(:example_map) do
    maps = Hash.new { |h, k| h[k] = [] }
    map_name = nil
    example_data.each do |line|
      case line
      when /map:$/ then map_name = line.split.first
      when /^\d/ then maps[map_name] << line
      end
    end
    maps
  end

  describe '.output' do
    subject(:output) { mapper.output }

    let(:input) { [].each }

    it { is_expected.to eq :test_type }
  end

  describe '.[]' do
    context 'with the example seed to soil map' do
      let(:input) { example_map['seed-to-soil'].each }

      [
        [0, 0], [1, 1], [48, 48], [49, 49], [50, 52], [51, 53],
        [96, 98], [97, 99], [98, 50], [99, 51]
      ].each do |x, y|
        it "maps #{x} to #{y}" do
          expect(mapper[x]).to eq y
        end
      end
    end

    context 'with a range' do
      let(:input) { example_map['seed-to-soil'].each }

      example 'it correctly maps a range below all bands' do
        expect(mapper[30..32]).to eq [30..32]
      end

      example 'it correctly maps a range above all bands' do
        expect(mapper[100..102]).to eq [100..102]
      end

      example 'it correctly maps a range entirely within a band' do
        expect(mapper[98..99]).to eq [50..51]
      end

      example 'it splits a range at the top of the mapping' do
        expect(mapper[98..102]).to contain_exactly(50..51, 100..102)
      end

      example 'it splits a range at the bottom of the mapping' do
        expect(mapper[40..60]).to contain_exactly(40..49, 52..62)
      end
    end
  end
end
