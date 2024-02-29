# Raise an error when trying to access out of bound index
  # raise IndexError if index.negative? || index >= @buckets.length
# Create a hash map of 16 buckets
# Hash map does not preserve insertion order
# put each key and value pair into a bucket as a node

# 2 Approaches
  # linked list approach/chaining implementation is reccomended but not required to deal with collision?
    # buckets is an instance variable containing the array 
    # Don't need to double buckets as linked list handles collision


  # linear approach/open addressing: place data in buckets, add index one linearly to hash value until empty ?
    # Keep the original key?
    # load factor = number of entries / number of slots
    # double buckets? when load factor greater than .75
      # Rehasing: Double array and copy everything over
    # edge case: find a key/value that's been set further than original position with element before removed

# What to look up: how to store/display as node


class HashMap

  def initialize
    @buckets = Array.new(16, nil)
    @current_node = nil
    @current_bucket = nil
    @index = nil
  end

  def run
     set('Jerry', 'I am the old value.')
     set('Jerry', 'I am the new value.')
     set('Jerryl', 'I should be incremented.')
     set('Mogu', 'I am a dog.')
     set('Jerryl', 'Increment and replace no loop.')
     set('Jerrym', 'I should be looped.')
     set('Mogu', 'New doggy.')
     set('Jerrym', 'Loop and replace.')

     p @buckets
  end

# hash function takes key or string as input and returns hashcode (the array index of a bucket between 0-15)
  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = (prime_number * hash_code + char.ord)%16 }
       
    hash_code
  end

  # 2 arguments value assigned to key

  # overwrite value if key exists or is empty

  # check if there is enough room to add to table 
    # if not trigger rebuild operation

  # handle collision
  # go up until we find an empty position or run out (increment address until empty function)

  # what happens if we run out of room at end of index after incrementing?
    # loop hash table to beginning
  def set(key, value)
    p @index = hash(key) #hashes key into an index number
    @current_node = Node.new(key, value) #store node in instance variable
  
    loop do
      break if set_base_case(@index) == true #assigns key to bucket or increment index
      @index = loop_through(@index) # loops to beginning 
      raise IndexError if @index.negative? || @index >= @buckets.length
    end
  end

  def set_base_case(index)
    @current_bucket = @buckets[index]

    if @buckets[index] == nil # place key on first nil bucket 
      @buckets[index] = @current_node
      return true
    elsif @current_node.key == @current_bucket.key # if key is the same change the value
      @buckets[index] = @current_node
      return true
    else
      @index+=1
    end
  end

  #def increment_bucket(index)
  #  return index+=1
  #end

  def loop_through(index)
    if index == @buckets.length
      index = 0
    else 
      index
    end
  end

  # Keep track of total number of buckets #capacity
  # check if load factor is > .75 then double buckets if true
    # load factor = number of entries / number of slots
  def rebuild 
  end 

  # Get the key or return nil
  # Check original key and move up one until found?
  def get(key)

  end

  # Return true or false if key exists
  def has(key)

  end

  # Remove entry with the key and return deleted value otherwise return nil
  # Use get then delete entry
  def remove(key)
  end

  # Return number of stored keys
  def length
  end

  # Return array containing all values
  def values

  end

  # Print contents and Return array containing each key,value. Example: [[first_key, first_value], [second_key, second_value]]
  def entries

  end

end

class Node
  attr_accessor :key, :value

  def initialize(key = nil, value = nil)
    @key = key
    @value = value
  end
end

hash = HashMap.new
hash.run
    