#!/usr/bin/env ruby
# frozen_string_literal: true

words = %w[zero one two three four five six seven eight nine]
digit = /[0-9]|#{words.join('|')}/
value = words.each_with_index.to_h

s = ARGF.each_line.map do |l|
  digs = l.partition(digit)[1], l.rpartition(digit)[1]
  first, last = digs.map { |d| d.length > 1 ? value[d] : d.to_i }

  first * 10 + last
end.sum

puts s
