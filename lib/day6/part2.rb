# frozen_string_literal: true

module Day6
  # Same as part 1 but it's one race
  class Part2 < Part1
    def parse(data)
      inputs = data.to_h do |l|
        k, s = l.split(':', 2)
        [k, s.gsub(/\s+/, '').to_i]
      end

      [Race.new(inputs['Time'], inputs['Distance'])]
    end

    def margin
      @races.first.margin
    end
  end
end
