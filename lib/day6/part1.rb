# frozen_string_literal: true

module Day6
  # Work out how long to hold the button for
  class Part1
    # Simple helper class to hold race info
    class Race
      def initialize(time, distance)
        @time = time
        @distance = distance
      end

      attr_reader :time, :distance

      def winning_times
        # d = run_time * speed
        # speed = hold_time
        # run_time = time - hold_time
        #
        # d = (time - hold_time) * hold_time
        # d = time * hold_time - hold_time²
        # time * hold_time - hold_time² - d = 0
        # ax² + bx + c = 0
        # a = -1, b = time, c = -d
        min, max = solve_quadratic(-1, time, -distance)
        ((min + 1).floor)..((max - 1).ceil)
      end

      def margin
        winning_times.size
      end

      def solve_quadratic(a, b, c) # rubocop:disable Naming/MethodParameterName
        sqrt_term = Math.sqrt((b * b) - (4 * a * c))
        over_2a = 1.0 / (2 * a)
        x0 = (-b + sqrt_term) * over_2a
        x1 = (-b - sqrt_term) * over_2a
        x0 < x1 ? [x0, x1] : [x1, x0]
      end
    end

    def initialize(data)
      @races = parse(data)
    end

    def parse(data)
      inputs = data.to_h do |l|
        k, s = l.split(':', 2)
        [k, s.split.map(&:to_i)]
      end

      inputs['Time'].zip(inputs['Distance']).map do |t, d|
        Race.new(t, d)
      end
    end

    def race(number)
      @races[number - 1]
    end

    def product
      @races.map(&:margin).inject(:*)
    end

    def self.result(file)
      new(file.each_line).product
    end
  end
end
