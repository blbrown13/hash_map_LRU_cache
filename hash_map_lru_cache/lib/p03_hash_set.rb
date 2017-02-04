require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    key = key.hash
    resize! if count >= num_buckets
    self[key] << key unless self[key].include?(key)
    @count += 1
  end

  def include?(key)
    key = key.hash
    self[key].include?(key)
  end

  def remove(key)
    key = key.hash
    self[key].delete(key) if include_hash?(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num = num.hash
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def include_hash?(hash)
    self[hash].include?(hash)
  end

  def resize!
    new_size = 2 * num_buckets
    new_store = Array.new(new_size){Array.new}
    @store.each do |bucket|
      bucket.each do |num|
        num = num.hash
        new_store[num % new_size] << num
      end
    end
    @store = new_store
  end
end
