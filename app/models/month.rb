# frozen_string_literal: true
require 'date'

class Month
  NAMES = {
    1 => :January,
    2 => :February,
    3 => :March,
    4 => :April,
    5 => :May,
    6 => :June,
    7 => :July,
    8 => :August,
    9 => :September,
    10 => :October,
    11 => :November,
    12 => :December,
  }.freeze

  def initialize(year, number)
    raise ArgumentError, 'invalid month number' unless NAMES.key?(number)

    @year = year
    @number = number

    freeze
  end

  attr_reader :year, :number

  def to_s
    "#{@year}-#{@number.to_s.rjust(2, '0')}"
  end

  def name
    NAMES.fetch(@number)
  end

  NAMES.each do |number, name|
    define_method(:"#{name.downcase}?") do
      @number == number
    end
  end

  def hash
    [@year, @number].hash
  end

  def eql?(other)
    other.class == self.class && other.hash == hash
  end

  def <=>(other)
    return @number <=> other.number if @year == other.year
    @year <=> other.year
  end

  include Comparable

  def next
    return self.class.new(@year + 1, 1) if @number == 12
    self.class.new(@year, @number + 1)
  end

  alias succ next

  def step(limit, step = 1)
    raise ArgumentError if step.zero?

    return enum_for(:step, limit, step) unless block_given?

    month = self

    until step.positive? ? month > limit : month < limit
      yield month
      month += step
    end
  end

  def upto(max, &block)
    step(max, 1, &block)
  end

  def downto(min, &block)
    step(min, -1, &block)
  end

  def +(other)
    a, b = (@number - 1 + other).divmod(12)

    self.class.new(@year + a, b + 1)
  end

  def -(other)
    return self - other if other.is_a?(Integer)
    (year * 12 + @number) - (other.year * 12 + other.number)
  end

  def include?(date)
    @year == date.year && @number == date.month
  end

  alias === include?

  def start_date
    Date.new(@year, @number, 1)
  end

  def end_date
    Date.new(@year, @number, -1)
  end

  def dates
    start_date..end_date
  end

  def length
    end_date.mday
  end
end

def Month.parse(string)
  raise ArgumentError, 'invalid month' unless string =~ /\A(\d{4})-(\d{2})\z/
  Month.new(Regexp.last_match[1].to_i, Regexp.last_match[2].to_i)
end

class Month
  module Methods
    NAMES.each do |number, name|
      define_method(name) do |*args|
        case args.length
        when 1
          Month.new(args.first, number)
        when 2
          Date.new(args[1], number, args[0])
        else
          raise ArgumentError, 'too many arguments'
        end
      end
    end
  end
end
