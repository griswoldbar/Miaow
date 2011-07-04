class SectionBuilder
  attr_reader :section
  
  def initialize(song,part)
    @section=Section.new(song,part)
  end

  def create_section
    create_motif
    fit_motif
    create_template
    create_melody
    shift_melody
		quantize_melody
  end

  private
  
      def create_motif
        @section.motif=MotifFactory.generate(@section.part[:style])
      end
      
      def fit_motif(n=TICKS)
        @section.motif.fit_motif
      end
      
      def create_template
        @section.template=TemplateFactory.generate(@section.motif,@section.song.bar_count,@section.part[:style])
      end
      
      def create_melody(n=TICKS)
        @section.melody=[]
        i=0
        bar=1
        max_strike_on=0
				motif_style=@section.motif.style
        @section.song.chords.cycle(@section.song.duration) do |chord|
          max_strike_on+=(n*chord.length/4)
					start_of_bar=true
          while song_end_not_reached?(i,@section.template.strikes.length)
            strike=@section.template.strikes[i]        
            break if end_of_bar?(strike[:on],max_strike_on) 
            if start_of_bar==true && motif_style == :chord
						  notes=NoteFactory.generate(chord,strike,motif_style,:tonic)
						else
              notes=NoteFactory.generate(chord,strike,motif_style) 
						end
            notes.flatten.each {|note| @section.melody<<note}
            i+=1
						start_of_bar=false
          end
          bar+=1
        end
      end
      
      def shift_melody
        shift_factor=@section.part[:pitch]*12
        @section.melody.each {|note| note.tone+=shift_factor}
      end

			def quantize_melody
			  ticks=@section.song.ticks
        quant=@section.part[:quant]
        @section.melody.each do |note|
          length=note.off-note.on
					note.on=note.on.roundnearest(quant)
					note.off=note.on+length
				end
			end
      
      def end_of_bar?(position,end_of_bar)
        position>end_of_bar
      end
      
      def song_end_not_reached?(position,song_length)
        position<song_length
      end
      
end

