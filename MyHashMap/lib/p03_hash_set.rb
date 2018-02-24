require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if include?(num)
      return nil
    elsif count + 1 == num_buckets
      resize!
      @store[num.hash % num_buckets] << num
    else
      @store[num.hash % num_buckets] << num
    end

    @count += 1
  end

  def remove(num)
    @store[num.hash % num_buckets].delete(num)
    @count -=1 if include?(num)
  end

  def include?(num)
    @store[num.hash % num_buckets].include?(num)
  end

  private

  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup.flatten
    @store = Array.new(num_buckets * 2) { Array.new }
    old_store.each { |el| @store[el.hash % num_buckets] << el }
  end
end
