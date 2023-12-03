# frozen_string_literal: true

module Day3
  # Representation of a schematic with symbols and numbers
  class Schematic
    def initialize(enum)
      @sch = enum.to_a.map(&:chomp)
    end

    def part_numbers
      parts = numbers.select do |num|
        cols = num[:cols]
        num[:rows].any? do |r|
          symbols_in_row(r).any? do |sym|
            cols.cover? sym[:col]
          end
        end
      end

      parts.map { |n| n[:num] }
    end

    def gears
      symbols.map do |sym|
        next unless sym[:sym] == '*'

        numbers = numbers_near_symbol(sym)
        next unless numbers.length == 2

        nums = numbers.map { |n| n[:num] }

        {
          numbers: nums,
          ratio: nums.inject(:*)
        }
      end.compact
    end

    private

    def symbols
      @symbols ||= scour_for(/[^\d.]/) do |row, match|
        {
          sym: match.to_s,
          row:,
          col: match.begin(0)
        }
      end
    end

    def numbers
      @numbers ||= scour_for(/\d+/) do |row, match|
        {
          num: match.to_s.to_i,
          row:,
          rows: row - 1..row + 1,
          cols: match.begin(0) - 1..match.end(0)
        }
      end
    end

    def numbers_near_symbol(sym)
      row, col = sym.values_at(:row, :col)
      (row - 1..row + 1).flat_map do |r|
        numbers_in_row(r).select do |n|
          n[:cols].cover? col
        end
      end
    end

    def symbols_in_row(row)
      @sym_by_row ||= symbols.group_by { |s| s[:row] }
      @sym_by_row[row] || []
    end

    def numbers_in_row(row)
      @num_by_row ||= numbers.group_by { |n| n[:row] }
      @num_by_row[row] || []
    end

    def scour_for(regex, &)
      results = []

      @sch.each_with_index do |line, r|
        pos = 0
        while (m = line.match(regex, pos))
          pos = m.end(0)
          res = yield r, m
          results << res if res
        end
      end

      results
    end
  end
end
