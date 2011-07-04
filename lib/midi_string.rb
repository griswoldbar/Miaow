class MidiString

  attr_reader :str
  
  def initialize(header,events)
    track_string=get_track_string(events)
    track_length=get_track_length(track_string)
    @str=build_midi_string(header, track_length,track_string)
  end

  private
  
  def get_track_length(track_string)
    track_length=(track_string.length/2).to_s(16).rjust(8,"0")
  end

  def get_track_string(events)
    track_string=""
    events.each do |event|
      track_string<<event.hex_data
    end
      track_string<<"ac69ff2f00"
      track_string
  end

  def build_midi_string(header, track_length, track_string)
    midi_string=""
    header.each_value do |i|
      midi_string<<i
    end
    midi_string<<track_length
    midi_string<<track_string
    midi_string
  end

end
