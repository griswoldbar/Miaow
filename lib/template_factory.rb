class TemplateFactory

  def self.generate(motif,bar_count,style="")
    begin
      template_class=const_get(style.to_s.capitalize+"Template")
      template=template_class.new(motif,bar_count)
    rescue
      template=Template.new(motif,bar_count)
    end
  end

end


