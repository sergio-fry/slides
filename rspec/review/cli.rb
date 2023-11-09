#!/usr/bin/env ruby

class GreppedLines
  include Enumerable

  def initialize(pattern)
    @pattern = pattern
  end

  def each(&block)
    `ack-grep #{@pattern}`.split("\n").each(&block)
  end
end

puts(GreppedLines.new('TODO:').reject { |l| l.match?('sandbox') })
