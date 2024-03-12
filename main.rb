# Create a hash map of 16 buckets
# Hash map does not preserve insertion order
# put each key and value pair into a bucket as a node


  # linear approach/open addressing: place data in buckets, add index one linearly to hash value until empty ?
    # Keep the original key?
    # load factor = number of entries / number of slots
    # double buckets? when load factor greater than .75
      # Rehasing: Double array and copy everything over
    # edge case: find a key/value that's been set further than original position with element before removed



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
    set('Jerrym', 'Loop and replace.')
    set('Jerryp', 'Loop and add.')
    set('Jerryq', 'Loop and add.')
    set('Jerryr', 'Loop and add.')
    set('Jerrys', 'Loop and add.')
    set('Jerryt', 'Loop and add.')
    set('Jerryu', 'Loop and add.')
    set('Jerryv', 'Loop and add.')
    set('Jerryx', 'Loop and add.')
    set('Jerryy', 'test.')
    set('Jerryo', 'I should be at end after load.')
    set('Jerrym', 'I should be looped.')
    set('Mogu', 'New doggy.')
    set('ADDZAg', 'ADD.')


    length
    p @buckets
    p calculate_load_factor
    p entries
    
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

  # Raise an error when trying to access out of bound index
  def set(key, value)
    p @index = hash(key) #hashes key into an index number
    @current_node = Node.new(key, value) #store node in instance variable but not bucket yet
    exists = get(key)
    rebuild

  
    loop do
      break if set_base_case(@index, exists) == true #assigns key to bucket or increment index
      @index = loop_through(@index) # loops to beginning 
      raise IndexError if @index.negative? || @index >= @buckets.length
    end
  end

  def set_base_case(index, exists)
    @current_bucket = @buckets[index]
    #p @buckets[index]
    #p "Current bucket: #{@current_bucket}"
    #p "key value: #{exists}"

    if @buckets[index] == nil && exists == nil # place key on first nil bucket add a flag if bucket is nil and flag is false
      @buckets[index] = @current_node
      return true
    elsif @buckets[index] == nil && exists != nil #prevents nil error, keeps incrementing if given hash value already exists in table
      @index+=1
      return
    elsif @current_node.key == @current_bucket.key # if key is the same change the value
      @buckets[index] = @current_node
      return true
    else
      @index+=1
    end
  end

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
    load_factor = calculate_load_factor

    if load_factor >= 0.75
      clone_buckets = Array.new(@buckets.length, nil)
      double_buckets = @buckets += clone_buckets
      p @buckets
    end
  end 

  def calculate_load_factor
    bucket_amt = @buckets.length
    entries = bucket_amt - @buckets.count(nil)
    load_factor = entries/bucket_amt.to_f

  end

  # Get the key and return value or return nil
  # Check original key and move up one until found? just check from start

  # add everything to an array?, check through that array of strings/nil so it's easier and not in node form 
  # each do entry, if array[0] == key then return array[1] if not then nil?
  # return nil if array index == bucket amount?
  def get(key)
    hash_entries = entries
    value = nil 

    hash_entries.each do |bucket|
      if key == bucket[0]
        value = bucket[1]
      else
        next
      end
    end

    value
      
  end

  # Return true or false if key exists
  # just use include on the array
  def has(key)
    keys
    p keys.include?(key)
  end

  # Remove entry with the key and return deleted value otherwise return nil
  # Use get then delete entry
  # will be the only hard method logically
  def remove(key)
    @buckets.each_with_index do |bucket, index|
      @current_bucket = bucket
      if @current_bucket == nil
        next
      elsif @current_bucket.key != key
        next
      elsif @current_bucket.key == key
        p @current_bucket.value
        @buckets[index] = nil
      end
    end
  end

  # Return number of stored keys
  # count the array
  def length
    puts "Stored keys in hash map: #{values.length}"
  end

  # removes all entries in the hash map.
  def clear
    @buckets = Array.new(16, nil)
  end

  # returns an array containing all the keys inside the hash map
  def keys
    buckets_keys = []

    @buckets.each do |bucket|
      @current_bucket = bucket
      if @current_bucket == nil
        next
      else
        buckets_keys << @current_bucket.key
      end
    end

    buckets_keys
  end

  # Return array containing all values
  # add all the values to an array
  def values
    buckets_values = []

    @buckets.each do |bucket|
      @current_bucket = bucket
      if @current_bucket == nil
        next
      else
        buckets_values << @current_bucket.value
      end
    end

    buckets_values

  end

  # Print contents and Return array containing each key,value. Example: [[first_key, first_value], [second_key, second_value]]
  def entries
    buckets_entries = []

    @buckets.each do |bucket|
      bucket_entry = []
      @current_bucket = bucket
      if @current_bucket == nil
        next
      else
        bucket_entry << @current_bucket.key
        bucket_entry << @current_bucket.value
        buckets_entries << bucket_entry
      end
    end

    buckets_entries

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
    