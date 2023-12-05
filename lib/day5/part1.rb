# frozen_string_literal: true

require_relative 'mapper'

module Day5
  # Follow seed numbers through several range mappings
  class Part1
    def initialize(lines)
      @lines = lines
      @seeds = @lines.next.scan(/\d+/).map(&:to_i)
    end

    attr_reader :seeds

    def maps
      return @maps if @maps
      @maps = {}

      loop do
        line = @lines.next.chomp
        next unless line =~ /\bmap:$/

        from, to = line.split.first.split('-to-')
        @maps[from] = Mapper.new(to, @lines)
      end

      @maps
    end

    def map(value, type, target)
      type = type.to_s
      target = target.to_s

      while maps.key?(type) && type != target
        map = maps[type]
        type = map.output
        value = map[value]
      end

      value
    end

    def lowest
      seeds.map { |n| map(n, :seed, :location) }.min
    end

    def self.result(file)
      new(file.each_line).lowest
    end
  end
end
