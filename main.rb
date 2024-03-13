class HashMap

  def initialize
    @buckets = Array.new(16, nil)
    @current_node = nil
    @current_bucket = nil
    @index = nil
  end

  # Debugging / manual testing
  # def run
  #   set('Jerry', 'I am the old value.')
  #   set('Jerry', 'I am the new value.')
  #   set('Jerryl', 'I should be incremented.')
  #   set('Mogu', 'I am a dog.')
  #   set('Jerryl', 'Increment and replace no loop.')
  #   set('Jerrym', 'Loop and replace.')
  #   set('Jerryp', 'Loop and add.')
  #   set('Jerryq', 'Loop and add.')
  #   set('Jerryr', 'Loop and add.')
  #   set('Jerrys', 'Loop and add.')
  #   set('Jerryt', 'Loop and add.')
  #   set('Jerryu', 'Loop and add.')
  #   set('Jerryv', 'Loop and add.')
  #   set('Jerryx', 'Loop and add.')
  #   set('Jerryy', 'test.')
  #   set('Jerryo', 'I should be at end after load.')
  #   set('Jerrym', 'I should be looped.')
  #   set('Mogu', 'New doggy.')
  #   set('ADDZAg', 'ADD.')
  #   length
  #   remove("Mogu")
  #   remove("ADDZAg")
  #   p @buckets
  #   p calculate_load_factor
  #   p entries
  # end


# Takes string or key and return index position between 0-15
  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = (prime_number * hash_code + char.ord)%16 }
       
    hash_code
  end

  # Sets bucket as node, overwrites values, trigger rehash function, handles collisions
  # Linear approach incrementing index position and looping to beginning
  def set(key, value)
    @index = hash(key)
    @current_node = Node.new(key, value)
    exists = get(key)
    rebuild

  
    loop do
      break if set_base_case(@index, exists) == true 
      @index = loop_through(@index)
      raise IndexError if @index.negative? || @index >= @buckets.length # out of bounds
    end
  end


  # Checks for four conditions at each index position. Base case increments index position or assigns to first empty nil position. Increments and changes duplicate key values. 
  def set_base_case(index, exists)
    @current_bucket = @buckets[index]

    if @buckets[index] == nil && exists == nil 
      @buckets[index] = @current_node
      return true
    elsif @buckets[index] == nil && exists != nil 
      @index+=1
      return
    elsif @current_node.key == @current_bucket.key
      @buckets[index] = @current_node
      return true
    else
      @index+=1
    end
  end

  # Loop index to beginning when end of table is reached
  def loop_through(index)
    if index == @buckets.length
      index = 0
    else 
      index
    end
  end

  # Doubles buckets if load factor is met
  def rebuild 
    load_factor = calculate_load_factor

    if load_factor >= 0.75
      clone_buckets = Array.new(@buckets.length, nil)
      double_buckets = @buckets += clone_buckets
      p @buckets
    end
  end 

  # Load factor = number of entries / number of slots available
  def calculate_load_factor
    bucket_amt = @buckets.length
    entries = bucket_amt - @buckets.count(nil)
    load_factor = entries/bucket_amt.to_f

  end

  
  # Return value of a given key
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
  def has(key)
    keys
    p keys.include?(key)
  end


  # Remove key/value from bucket and return value
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
  def length
    puts "Stored keys in hash map: #{values.length}"
  end

  # Removes all hashmap entries
  def clear
    @buckets = Array.new(16, nil)
  end

  # Array containing all keys
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

  # Array containing all values
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

  # Print array of contents [[first_key, first_value], [second_key, second_value]]
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

# Store each pair as node in bucket
class Node
  attr_accessor :key, :value

  def initialize(key = nil, value = nil)
    @key = key
    @value = value
  end
end

hash = HashMap.new
#hash.run
    