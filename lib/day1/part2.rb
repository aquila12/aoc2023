# frozen_string_literal: true

module Day1
  # Form a number from the first and last digit per line
  class Part2
    WORDS = %w[zero one two three four five six seven eight nine]
    DIGIT = /[0-9]|#{WORDS.join('|')}/
    VALUE = WORDS.each_with_index.to_h

    def calibration_value(line)
      digs = line.partition(DIGIT)[1], line.rpartition(DIGIT)[1]
      first, last = digs.map { |d| d.length > 1 ? VALUE[d] : d.to_i }

      (first * 10) + last
    end

    def sum(enumerator)
      enumerator.sum(&method(:calibration_value))
    end

    def result(file)
      sum file.each_line
    end
  end
end
