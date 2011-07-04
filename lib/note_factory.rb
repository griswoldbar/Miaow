class NoteFactory
  def self.generate(chord,strike,motif_type,style=:other)
    @chord=chord
    @strike=strike
    @type=chord.type.to_sym
    @key=chord.key
    notes=[]
		puts motif_type
		puts @strike
		if style==:tonic 
		  notes<<make_tonic_note
		elsif motif_type==:gentle
		  notes<<make_motif_note
    elsif @strike[:chord_depth]==1 && motif_type==:modal
      notes<<make_mode_note
    else
      notes<<make_chord_notes
    end
    notes
  end
  
  def self.make_motif_note
	  get_note_set(false)
		blank=@strike[:blank]
    note=Note.new(@note_set[blank],@strike,@key)
	end

	def self.make_tonic_note
    note=Note.new(0,@strike,@key)
	end

  def self.make_chord_notes
    chord_depth=@strike[:chord_depth]
    get_note_set
    poss_tones=@note_set.sample(chord_depth)
    notes=poss_tones.map do |poss_tone|
      note=Note.new(poss_tone,@strike,@key)
    end
  end
  
  def self.make_mode_note
    get_note_set(false)
    Note.new(@note_set.sample,@strike,@key)
  end
  
  def self.get_note_set(chord=true)
    if chord==true
      @note_set=NOTE_SETS[@type][:pattern]
    else
      mode=NOTE_SETS[@type][:modes].sample
      base_note_set=NOTE_SETS[mode.to_sym][:pattern]
			@note_set=base_note_set.cycle(2).each_with_index.map {|x,y| x+12*(y/base_note_set.size)}
		end
    @note_set
  end
  
end
