class Numeric
  def roundup(nearest=10)
    self % nearest == 0 ? self : self + nearest - (self % nearest)
  end
	def rounddown(nearest=10)
    self % nearest == 0 ? self : self - (self % nearest)
	end
	def roundnearest(nearest=10)
    up=roundup(nearest)
		down=rounddown(nearest)
		(up - self) < (self - down) ? up : down
	end
end
