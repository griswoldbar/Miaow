class Template
#basic template, simply repeats motif and randomly inserts chords. no actual tones selected at this point
  attr_reader :strikes
  
  def initialize(motif,bar_count,n=TICKS)
    @strikes=[]
    @motif=motif
    @bar_count=bar_count
    @ticks=n
    @motif_length=motif.strikes.length
    make_strikes
  end
  
  def make_strikes
    i=0
    @motif.strikes.each_slice(@motif_length).cycle(@bar_count) do |slice|
      slice.each do |strike|
        chord_depth=get_chord_depth(strike)
        @strikes<<{:on => strike[:on]+(@ticks*i),
                   :off => strike[:off]+(@ticks*i),
                   :velocity => 32,
                   :chord_depth => chord_depth,
									 :blank => strike[:blank]}      
      end
      i+=1
    end  
  end
  
  def get_chord_depth(strike)
    if rand(4)!=0
      1
    else
      rand(3)+1
    end
  end
  
end

class GentleTemplate<Template
  def make_strikes
    i=0
    @motif.strikes.each_slice(@motif_length).cycle(@bar_count) do |slice|
      slice.each do |strike|
        chord_depth=get_chord_depth(strike)
        @strikes<<{:on => strike[:on]+(@ticks*2*i),
                   :off => strike[:off]+(@ticks*2*i),
                   :velocity => 32,
                   :chord_depth => chord_depth,
									 :blank => strike[:blank]}      
      end
      i+=1
    end  
  end
  

end

class RagbassTemplate<Template

  def get_chord_depth(strike)
    strike[:multi_note]
  end
  
end


class WalkingTemplate<Template
  
  def get_chord_depth(strike)
    1
  end

end

