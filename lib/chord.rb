class Chord
  attr_accessor :key,
                :type,
                :length
  
  def initialize(key,type,length)
    @key=key
    @type=type
    @length=length.to_i
  end
  
end

