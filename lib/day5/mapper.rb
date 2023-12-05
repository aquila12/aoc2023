# frozen_string_literal: true

module Day5
  # Maps destination ranges from source ranges
  class Mapper < Hash
    def initialize(input_lines)
      super() { |_, input| input }

      input_lines.each do |line|
        o, i, length = line.split.map(&:to_i)
        length.times { |n| self[i + n] = o + n }
      end
    end
  end
end
