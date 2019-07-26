# typed: strong

class AbstractFunction
  def >>(another)
    lambda { |*args| another.to_proc.call(self.to_proc.call(*args)) }
  end

  def call(*args)
    to_proc.call(*args)
  end

  def to_proc; end
end

class Increment < AbstractFunction
  def initialize
    @proc = -> (n) { n + 1 }
  end

  def to_proc
    @proc
  end
end

class Double < AbstractFunction
  def initialize
    @proc = -> (n) { n * 2 }
  end

  def to_proc
    @proc
  end
end

incr = Increment.new { |n| n + 1 }
double = Double.new { |n| n * 2 }
composed = incr >> double

puts composed.call(1)
