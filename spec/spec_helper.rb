# frozen_string_literal: true

$LOAD_PATH << File.join(__dir__, '../lib')

require 'timeout'

module RSpecMixin
  def with_input(filename)
    path = File.join(__dir__, '..', 'input', filename.to_s)

    before { @f = File.open(path) }
    after { @f.close }

    let(:input_file) { @f }
    let(:input_lines) { @f.each_line }
  end

  def with_example_data(filename)
    path = File.join(__dir__, 'examples', filename.to_s)

    let(:example_data) { File.readlines(path) }
  end
end

RSpec.configure do |c|
  c.extend RSpecMixin

  c.around(:each) do |example|
    Timeout::timeout(2) { example.run }
  end
end
