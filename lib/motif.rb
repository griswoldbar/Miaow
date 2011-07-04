class Motif

  attr_accessor :strikes, 
	              :endpoint
	attr_reader		:style

  def initialize(style=:modal)
    @strikes=Array.new
    @endpoint=0
    set_strike_count
    create_strikes
		add_blanks
  end
  
  def set_strike_count(n=TICKS/24)
    @strike_count=rand(n)+12
  end
  
  def create_strikes(n=TICKS/2)
    strike_off=0
    @strike_count.times do |x|
      strike_on=strike_off+rand(n/@strike_count)
      strike_off=strike_on+rand(n/@strike_count)+1
      multi_note=rand(4)+1
      @strikes<<{:on => strike_on, :off => strike_off, :multi_note=>multi_note}
    end
    @endpoint=strike_off+rand(n/@strike_count)
  end

  def add_blanks
	  previous=0
    @strikes.each_with_index do |strike,index|
		  while strike[:blank].nil?
        if rand(3)==0
			    strike[:blank]=rand(12)
				elsif rand(3)==1
          strike[:blank]=previous+1
				else
			    strike[:blank]=previous-1
			  end
			end
			previous=strike[:blank]
		end
	end

	def fit_motif(n=TICKS)
    @strikes.each do |strike|
      strike[:on]=strike[:on]*n/@endpoint
      strike[:off]=strike[:off]*n/@endpoint
    end
  end


end

class RagbassMotif<Motif
  
  def initialize(style)
    @style=:modal
		super
	end


	def set_strike_count
    @strike_count=4
	end

  def create_strikes(n=TICKS/48)
    strike_off=0
    @strike_count.times do |x|
      strike_on=strike_off+n/@strike_count*3
			strike_off=strike_on+n/@strike_count*3

			x % 2 == 0 ? multi_note=1 : multi_note=4
			@strikes<<{:on => strike_on, :off => strike_off, :multi_note=>multi_note}
		end
    @endpoint=strike_off+rand(n/@strike_count)

	end

end

class GentleMotif<Motif

  def initialize(style)
    @style=:gentle
		super
	end
  def set_strike_count
    @strike_count=rand(8)+8
  end

  def create_strikes(n=TICKS/2)
    strike_off=0
    @strike_count.times do |x|
      strike_on=strike_off+rand(n/@strike_count)
      strike_off=strike_on+rand(n/@strike_count)+1
      multi_note=rand(4)+1
      @strikes<<{:on => strike_on, :off => strike_off, :multi_note=>multi_note}
    end
    @endpoint=strike_off+rand(n/@strike_count)
  end

	def fit_motif(n=TICKS*2)
    @strikes.each do |strike|
      strike[:on]=strike[:on]*(n/@endpoint)
      strike[:off]=strike[:off]*(n/@endpoint)
    end
  end



end

class WalkingMotif<Motif

  def initialize(style)
    @style=:modal
		super
	end

  def set_strike_count
    @strike_count=8
  end

  
  def create_strikes(n=TICKS)
    strike_off=0
      @strike_count.times do |x|
      strike_on=strike_off
      strike_off=strike_on+n/@strike_count
      multi_note=1
      @strikes<<{:on => strike_on, :off => strike_off, :multi_note=>multi_note}
    end
    @endpoint=strike_off

  end
  
end

