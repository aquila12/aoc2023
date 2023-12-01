# frozen_string_literal: true

module Day1
  # Form a number from the first and last digit per line
  class Part1
    def calibration_value(line)
      digits = line.tr('^0-9', '').chars
      (digits.first.to_i * 10) + digits.last.to_i
    end

    def sum(enumerator)
      enumerator.sum(&method(:calibration_value))
    end

    def result(file)
      sum file.each_line
    end
  end
end
