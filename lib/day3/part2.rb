# frozen_string_literal: true

require_relative 'schematic'

module Day3
  # Find sum of products for "gears"
  class Part2
    def sum(...)
      Schematic.new(...).gears.map { |g| g[:ratio] }.sum
    end

    def result(file)
      sum file.each_line
    end
  end
end
