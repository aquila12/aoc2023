# frozen_string_literal: true

#require_relative 'card'

module Day5
  class Part1
    def seeds(lines)
      lines.flat_map { |l| l.scan(/\d+/) }.map(&:to_i)
    end

    def maps(lines)
      # Somehow split the lines up
      # Without loading them all
    end
  end
end
