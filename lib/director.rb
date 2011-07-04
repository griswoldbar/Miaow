class Director
#builds the song
  attr_reader :builder, :song
  def initialize
    get_song_data
    @builder=SongBuilder.new
    @builder.add_progression(@progression_string)
    @builder.duration=@duration
    @builder.parts=@parts
		@builder.ticks=@ticks
    @builder.generate_midi
    @builder.create_file('whibble.mid')
  end 
  
  def get_song_data
  #sample data for testing
    #@progression_string="4-dom7-4|9-dom7-4|2-dom7-4|7-dom7-4"
		@progression_string="3-M7-4|3-m7-2|8-dom7-2|5-m7-4|8-m7-2|1-dom7-2|7-m7-2|6-m7-1|11-dom7-1|5-m7-2|10-dom7-2|7-m7-2|7-m7-2|6-m7-1|11-dom7-1|5-m7-2|10-dom7-2"
		@duration=4
    @ticks=96
    @parts=Array.new
    @parts<<{:pitch => 5, :quant =>(@ticks/12), :instrument => :piano, :style => :gentle}
		@parts<<{:pitch => 3, :quant =>(@ticks/12), :instrument => :piano, :style => ""}
  end
  
end
