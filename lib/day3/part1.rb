# frozen_string_literal: true

module Day3
  # Find numbers with a symbol adjacent
  class Part1
    SYMBOL = /[^\d.]/

    def each_match(str, rex, &)
      e = Enumerator.new do |y|
        pos = 0
        while (m = str.match(rex, pos))
          pos = m.end(0)
          y << m
        end
      end
      block_given? ? e.each(&) : e
    end

    def part_numbers(sch)
      input_with_border(sch).each_cons(3).flat_map do |l1, l2, l3|
        each_match(l2, /\d+/).map do |m|
          r = (m.begin(0) - 1)..m.end(0)
          m.to_s.to_i if [l1, l2, l3].any? { |l| l[r].match?(SYMBOL) }
        end.compact
      end
    end

    def input_with_border(enumerator, &)
      e = Enumerator.new do |y|
        lines = enumerator.lazy.map { |l| ".#{l.chomp}." }
        first = lines.next

        borderline = '.' * first.length

        y << borderline
        y << first
        lines.each { |l| y << l }
        y << borderline
      end
      block_given? ? e.each(&) : e
    end

    def sum(...)
      part_numbers(...).sum
    end

    def result(file)
      sum file.each_line
    end
  end
end
