# Extend String class
class String
  def is_numeric?
    true if Float(self) rescue false
  end

  def is_url?
    return true if %r{(?i)\b((?:https?://|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?]))}.match(self)

    false
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

  # only capitalize initial letter and leave the rest alone
  def initial_capitalize
    str = self
    str[0] = str[0].chr.capitalize

    str
  end

  def urlize
    downcase.gsub("_", "-")
  end

  def deurlize
    gsub("-", "_")
  end

  # deurlizes to symbol
  def deurlize_to_sym
    deurlize.downcase.to_sym
  end

  # make it suitable for html attributes
  def html_attributify
    downcase.gsub(/[_\/\s]/, "-").gsub(/[^0-9a-z\-]+/, "")
  end
end

# extend Symbol
class Symbol
  def urlize
    to_s.urlize
  end
end