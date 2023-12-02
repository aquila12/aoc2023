# frozen_string_literal: true

lib = File.join(__dir__, './lib')
$LOAD_PATH << lib

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:lint)

rule default: %i[spec lint all]

rule all: FileList['lib/*/part?.rb'] do |t|
  t.prerequisites.each do |src|
    task = src.scan(%r{day(\d+)/part(\d)}).first.join('.')
    Rake::Task[task].invoke
  end
end

rule '' do |name|
  day, part = name.to_s.split('.')
  require "day#{day}/part#{part}"

  cls = Object.const_get "Day#{day}::Part#{part}"

  suffix = ["p#{part}", ''].detect { |suf| File.exist? "input/day#{day}#{suf}" }

  print "Day #{day} part #{part}... "
  t0 = Time.now

  File.open("input/day#{day}#{suffix}") do |f|
    print cls.new.result(f)
  end

  t1 = Time.now
  millis = ((t1 - t0) * 1000).round(3)
  puts " (#{millis} ms)"
end
