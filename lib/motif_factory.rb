class MotifFactory

  def self.generate(style)
    motif_class=const_get(style.to_s.capitalize+"Motif")
    motif=motif_class.new(style)
  end

end

