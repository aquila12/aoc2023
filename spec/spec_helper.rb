# frozen_string_literal: true

require_relative 'fixtures'

$LOAD_PATH << File.join(__dir__, '../lib')

module RSpecMixin
  def with_input(filename)
    path = File.join(__dir__, '..', 'input', filename.to_s)

    before { @f = File.open(path) }
    after { @f.close }

    let(:input_file) { @f }
    let(:input_lines) { @f.each_line }
  end

  def with_example_data(tag)
    let(:example_data) { FIXTURES[tag] }
  end
end

RSpec.configure { |c| c.extend RSpecMixin }
