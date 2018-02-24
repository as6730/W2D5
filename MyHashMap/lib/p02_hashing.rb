class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    total = 0

    self.each_with_index do |el, idx|
      total += el.hash * (idx + 1).hash
    end

    total
  end
end

class String
  def hash
    alphabet = ('a'..'z').to_a + ('A'..'Z').to_a
    total = 0
    self.each_char.with_index do |char, idx|
      total += alphabet.index(char).hash * (idx + 1).hash
    end

    total
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    total = 0

    self.each do |key, value|
      new_key = key.to_s.to_i(2) + '1'.to_i(2)
      new_value = value.to_s.to_i(2)

      total += new_key.hash + new_value.hash
    end

    total
  end
end
