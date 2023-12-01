#!/usr/bin/env ruby
# frozen_string_literal: true

s = ARGF.each_line.map do |l|
  digits = l.tr('^0-9', '').chars
  digits.first.to_i * 10 + digits.last.to_i
end.sum

puts s
