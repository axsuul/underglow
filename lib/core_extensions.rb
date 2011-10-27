# Extend String class
class String
  def is_numeric?
    true if Float(self) rescue false
  end

  # Coerces to Float or Fixnum otherwise String
  # If no type is given, it will determine the type to coerce to
  # If type is given (the standard type symbols like :integer, :string, etc), it will coerce to that type
  def coerce(type = nil)
    if type.nil?
      if is_numeric?
        self.strip.match(/^\d+$/) ? self.to_i : self.to_f
      elsif self.match(/true/i)
        true
      elsif self.match(/false/i)
        false
      else
        self
      end
    else
      type = type.to_sym

      case type
      when :string
        self
      when :integer
        self.to_i
      when :float
        self.to_f
      when :boolean # only true matches to true, else false for everything
        if self.match(/true/i)
          true
        else
          false
        end
      else  # unknown type, just return string
        self
      end
    end
  end
end