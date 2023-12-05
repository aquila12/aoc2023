# frozen_string_literal: true

module Day5
  # Maps destination ranges from source ranges
  class Mapper < Hash
    def initialize(output_type, input_lines)
      @output = output_type

      super() { |_, input| input }

      loop do
        line = input_lines.next.chomp
        break if line.empty?

        o, i, length = line.split.map(&:to_i)
        length.times { |n| self[i + n] = o + n }
      end
    end

    attr_reader :output
  end
end
