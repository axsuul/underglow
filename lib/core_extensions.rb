# Extend String class
class String
  def is_numeric?
    true if Float(self) rescue false
  end

  # Coerces to Float or Fixnum otherwise String
  def coerce
    if is_numeric?
      self.strip.match(/^\d+$/) ? self.to_i : self.to_f
    elsif self.match(/true/i)
      true
    elsif self.match(/false/i)
      false
    else
      self
    end
  end
end