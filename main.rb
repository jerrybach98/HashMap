# Raise an error when trying to access out of bound index
  # raise IndexError if index.negative? || index >= @buckets.length
  # buckets is an instance variable containing the array 
# Create a hash map of 16 buckets
# linked list implementation is reccomended but not required to deal with collision?
  # linked list approach
  # place data in buckets, add one linearly to hash value until empty ?
# learn how to calculate load factor?
# Hash map does not preserve insertion order



class HashMap

  def initialize
    @buckets = Array.new(16, nil)
  end

# hash function takes key as input 
# Use Hashcode to access bucket
# handles strings
  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  # 2 arguments value assigned to key
  # overwrite value of key exists
  def set(key, value)

  end

  # Get the key or return nil
  def get(key)

  end

  # Return true or false if key exists
  def has(key)

  end

  # Remove entry with the key and return deleted value otherwise return nil
  def remove(key)
  end

  # Return number of stored keys
  def length
  end

  # Return array containing all values
  def values

  end

  # Return array containing each key,value. Example: [[first_key, first_value], [second_key, second_value]]
  def entries

  end

end


    