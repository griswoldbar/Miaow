class SongBuilder

 attr_reader :sections
 include MidiMaths
  #builder class for song
  attr_reader :song
  
  def initialize
    @song=Song.new
  end
  
  def add_progression(progression_string)
  #adds a progresion string (e.g. 0-M-2|9-m-4|5-M-2|7-M-4)
    @song.progression=progression_string.split('|')
  end
  
  def duration=(duration)
  #adds a duration; i.e. number of times progression will repeat
    @song.duration=duration
  end

	def ticks=(ticks)
    @song.ticks=ticks
	end

  def parts=(parts)
  #adds parts, e.g. {:pitch => 2, :instrument => :piano, :style => :gentle }
    @song.parts=parts
  end
  
  def generate_midi
  #actually builds the midi file
    set_chords
    calculate_bar_count
    build_sections
    convert_to_midi
  end
  
  def create_file(file_name)
    File.open(file_name,'w') do |f|
      @song.midi_string.scan(/../).each do |byte|
        f.print byte.hex.chr
      end
    end
  end
  
  private
  
    def set_chords
      @song.chords=Array.new
      @song.progression.each do |chunk|
        chunk=chunk.split('-')
        chord=Chord.new(chunk[0],chunk[1],chunk[2])
        @song.chords<<chord
      end
    end
    
    def calculate_bar_count(n=4)
    #assuming a bar is four beats, 
      chord_total=0
      @song.chords.each do |chord|
        chord_total+=chord.length
      end
      @song.bar_count=chord_total/n*@song.duration
    end
      
    def build_sections
      @sections=@song.parts.map do |part|
        builder=SectionBuilder.new(@song,part)
        builder.create_section
        builder.section
      end
    end
    
    def convert_to_midi
      consolidate_notes
      generate_events
      @song.events.sort!
      hexify_events
      @song.midi_string=MidiString.new(MIDI_HEADER,@song.events).str
    end
    
    def consolidate_notes
      @song.notes=[]
      @sections.each do |section|
        section.melody.each {|note| @song.notes<<note}
      end
    end
    
    def generate_events
      @song.events=[]
      @song.notes.each do |note|
        [:note_on,:note_off].each {|type| @song.events<<Event.new(type,note)}
      end
    end
    
    def hexify_events
      last_event_time=0
      last_event_type="blah"
      count=0
      @song.events.each do |event|
        count+=1
        hex_tone=event.note.tone.to_s(16)
        raw_delta_time=event.time-last_event_time
        hex_delta_time=to_delta(raw_delta_time)
        hex_delta_time=add_zero(hex_delta_time)
        if event.type==last_event_type
          hex_event_type=""
        elsif event.type==:note_on
          hex_event_type="90"
        else
          hex_event_type="80"
        end
        hex_velocity=event.note.velocity.to_s(16)
        event.hex_data=hex_delta_time+hex_event_type+hex_tone+hex_velocity
        last_event_type=event.type
        last_event_time=event.time
      end

    end
    
end

