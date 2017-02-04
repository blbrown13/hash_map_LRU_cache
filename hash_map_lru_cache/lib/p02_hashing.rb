class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_number = 0
    self.each_with_index do |val, idx|
      hash_number += val.hash ^ idx.hash
    end
    hash_number
  end
end

class String
  def hash
    self.split('').map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_number = 0
    self.each do |key, val|
      hash_number += key.to_s.hash + val.to_s.hash
    end
    hash_number
  end
end
