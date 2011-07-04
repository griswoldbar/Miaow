class Note
  attr_accessor :tone,
                :on,
                :off,
                :velocity
  
  def initialize(tone,strike,key)
    @tone=tone.to_i+key.to_i

    @on=strike[:on]
    @off=strike[:off]
    @velocity=strike[:velocity]
  end
  
end

