  ALL_NOTES = %w{ c c# d d# e f f# g g# a a# b }
  NOTE_SETS = {
    :ionian => {:pattern => [0,2,4,5,7,9,11]},
    :dorian => {:pattern => [0,2,3,5,7,9,10]},
    :phrygian => {:pattern => [0,1,3,5,7,8,10]},
    :lydian => {:pattern => [0,2,4,6,7,9,11]},
    :mixolydian => {:pattern => [0,2,4,5,7,9,10]},
    :aeolian => {:pattern => [0,2,3,5,7,8,10]},
    :locrian => {:pattern => [0,1,3,5,6,8,10]},
      :M =>   {:pattern => [0,4,7],    :modes => [:ionian]},
      :m =>   {:pattern => [0,3,7],    :modes => [:dorian]},
      :M7 =>  {:pattern => [0,4,11],   :modes => [:ionian]},
      :m7 =>  {:pattern => [0,3,10],   :modes => [:dorian]},
      :dom7 =>  {:pattern => [0,4,10],   :modes => [:mixolydian]},
      :dim  =>  {:pattern => [0,3,6],    :modes => [:locrian]},
      :M9 =>  {:pattern => [0,4,11,2], :modes => [:lydian]},
      :M11 => {:pattern => [0,4,11,5], :modes => [:ionian]},
      :M13 => {:pattern => [0,4,11,9], :modes => [:ionian]},  
  }

MIDI_HEADER={ :mthd => "4d546864", 
                            :data_length => "00000006", 
                            :format => "0001",
                            :num_tracks => "0002",
                            :delta_ticks => "0032",
                            :tempo_track => "4d54726b0000002600ff510307a12000ff0116637265617465642077697468204d6964695377696e67bc00ff2f00",
                            :track_header => "4d54726b"
}

  
TICKS=192 

#      :M =>   {:pattern => [0,4,7],    :modes => [:ionian, :lydian, :mixolydian]},
#      :m =>   {:pattern => [0,3,7],    :modes => [:dorian, :phrygian, :aeolian]},
#      :M7 =>  {:pattern => [0,4,11],   :modes => [:ionian, :lydian]},
#      :m7 =>  {:pattern => [0,3,10],   :modes => [:dorian, :phrygian, :aeolian]},
#      :dom7 =>  {:pattern => [0,4,10],   :modes => [:mixolydian]},
#      :dim  =>  {:pattern => [0,3,6],    :modes => [:locrian]},
#      :M9 =>  {:pattern => [0,4,11,2], :modes => [:ionian, :lydian]},
#      :M11 => {:pattern => [0,4,11,5], :modes => [:ionian]},
#      :M13 => {:pattern => [0,4,11,9], :modes => [:ionian]},  
