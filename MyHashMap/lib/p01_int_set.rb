class MaxIntSet
  def initialize(max)
    @store = Array.new(max + 1, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true unless include?(num)
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num >= 0 && num < @store.length - 1
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    # @bucket_count = @store.length
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if include?(num)
      return nil
    elsif count + 1 == num_buckets
      resize!
      self[num] << num
    else
      self[num] << num
    end

    @count += 1
  end

  def remove(num)
    self[num].delete(num)
    @count -=1 if include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup.flatten
    @store = Array.new(num_buckets * 2) { Array.new }
    old_store.each { |el| @store[el % num_buckets] << el }
  end
end
