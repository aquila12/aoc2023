# frozen_string_literal: true

require_relative 'part1'
require 'prime'

module Day8
  # Desert map ghost traversal
  class Part2 < Part1
    # Can't believe Prime doesn't have this...
    def factors(number) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      return [1].each if number < 2

      primes, limits = number.prime_division.transpose

      iteration = Array.new(primes.length, 0)
      # [ 0 0 0 ], [ 0 0 1 ], [ 0 0 2 ], [ 0 1 0 ]

      Enumerator.new do |y|
        loop do
          y << Prime.int_from_prime_division([primes, iteration].transpose)

          f = 0
          while true # rubocop:disable Style/InfiniteLoop because we don't want to catch StopIteration here
            raise StopIteration unless f < primes.length

            iteration[f] += 1
            break if iteration[f] <= limits[f]

            iteration[f] = 0
            f += 1
          end
        end
      end
    end

    def sequence_period(string)
      length = string.length
      factors(length).detect do |len|
        string == string[0, len] * (length / len)
      end || length
    end

    # OK so here's my thoughts on this
    # First take the input sequence and make sure it's the minimum sequence length
    # i.e. LLLRLLLRLLLR -> LLLR
    # Then examine the input for state loops
    # i.e. Start from 11A, if we get back to 11A and the sequence position is the same
    # then we have a state loop, but we might not get back to 11A
    # Work out when we return to the same state:
    # How many steps to get to that state the first time
    # The period of the state loop
    # Something something product of periods ?!

    def reset
      @node = @nodes.keys.select { |n| n.end_with? 'A' }
    end

    def done?
      @node.all? { |n| n.end_with? 'Z' }
    end

    def advance!(direction)
      @node.map! { |n| @nodes[n][direction] }
    end

    def self.result(...)
      raise NotImplementedError
    end
  end
end
