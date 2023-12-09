# frozen_string_literal: true

lib = File.join(__dir__, './lib')
$LOAD_PATH << lib

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yaml'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:lint)

rule default: %w[spec lint all]

rule all: FileList['lib/*/part?.rb'] do |t|
  t.prerequisites.each do |src|
    task = src.scan(%r{day(\d+)/part(\d)}).first.join('.')
    Rake::Task[task].invoke
  end
end

rule :make do
  puts `cd ohno && make aoc2023`
end

rule stats: :make do
  files = %w[lib/*/*.rb spec/*/*.rb ohno/day*.c].flat_map { |g| Dir.glob(g) }
  stats = Hash.new { |h, k| h[k] = Hash.new { |h2, k2| h2[k2] = 0 } }

  files.each do |f|
    sloc = File.open(f, 'r') do |file|
      file.each_line.count do |l|
        l = l.chomp.strip
        next if l.empty?
        next if f.end_with?('.c') && l.start_with?('//')
        next if f.end_with?('.c') && l.start_with?('/*') && l.end_with?('*/')
        next if f.end_with?('.rb') && l.start_with?('#')

        true
      end
    end

    day, type = f.match(/(day\d+).*?((_spec)?\.(rb|c))/)[1..2]
    stats[type][day] += sloc
  end

  stats.each do |_, d|
    d['total'] = d.values.sum
    d.transform_values! { |n| "#{n} sloc" }
  end

  stats['.c']['binary'] = "#{File.size('ohno/aoc2023')} bytes"

  puts 'Statistics:'
  puts YAML.dump(stats)
end

rule '' do |name|
  day, part = name.to_s.split('.')
  require "day#{day}/part#{part}"

  cls = Object.const_get "Day#{day}::Part#{part}"

  suffix = ["p#{part}", ''].detect { |suf| File.exist? "input/day#{day}#{suf}" }

  print "Day #{day} part #{part}... "
  t0 = Time.now

  File.open("input/day#{day}#{suffix}") do |f|
    print cls.result(f)
  end

  t1 = Time.now
  millis = ((t1 - t0) * 1000).round(3)
  puts " (#{millis} ms)"
rescue NotImplementedError => e
  puts e
end
