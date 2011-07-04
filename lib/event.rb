class Event
  include Comparable
  attr_accessor :type, :note, :hex_data, :time

  def initialize(type, note)
    @type=type
    @note=note
    @time=case @type
            when :note_on
              @note.on
            when :note_off
              @note.off
            end
  end

  def hex_data=(value)
    @hex_data=value
  end

  def <=>(other_event)
    if self.time != other_event.time
      self.time <=> other_event.time
    elsif self.type==other_event.type
      self.time <=> other_event.time
    elsif self.type==:note_on
      -1
    else
      1
    end
  end
end

