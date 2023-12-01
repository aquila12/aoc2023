# frozen_string_literal: true

$LOAD_PATH << File.join(__dir__, './lib')

rule '' do |name|
  day, part = name.to_s.split('.')
  require "day#{day}/part#{part}"

  cls = Object.const_get "Day#{day}::Part#{part}"

  fname = %w[input1 input2 input].detect { |n| File.exist? "#{day}/#{n}" }

  File.open("#{day}/#{fname}") do |f|
    puts cls.new.result(f)
  end
end
