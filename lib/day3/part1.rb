# frozen_string_literal: true

require_relative 'schematic'

module Day3
  # Find numbers with a symbol adjacent
  class Part1
    def sum(...)
      Schematic.new(...).part_numbers.sum
    end

    def self.result(file)
      new.sum file.each_line
    end
  end
end
