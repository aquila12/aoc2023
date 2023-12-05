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
  end
end
