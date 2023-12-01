# frozen_string_literal: true

$LOAD_PATH << File.join(__dir__, '../lib')

module RSpecMixin
  def with_input(filename)
    before { @f = File.open(filename) }
    after { @f.close }

    let(:input_file) { @f }
    let(:input_lines) { @f.each_line }
  end
end

RSpec.configure { |c| c.extend RSpecMixin }
