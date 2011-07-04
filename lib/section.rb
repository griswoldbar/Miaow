class Section
  attr_accessor :phrases,
                :motif,
                :template,
                :melody
  attr_reader   :song,
                :part
                
  def initialize(song,part)
    @song=song
    @part=part
  end
  
end

