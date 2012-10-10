class String
  def numeric?
    true if Float(self) rescue false
  end
  
  def url?
    return true if %r{(?i)\b((?:https?://|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?]))}.match(self)

    false
  end

  # Coerces to Float or Fixnum otherwise String
  # If no type is given, it will determine the type to coerce to
  # If type is given (the standard type symbols like :integer, :string, etc), it will coerce to that type
  def coerce(type = nil)
    if type.nil?
      if numeric?
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

  # Concat another string and overlap it if it does
  def overlap(b)
    a = self
    a_len = self.length
    b_len = b.length
    n = nil

    (0..a_len-1).each do |i|
      j = i
      k = 0

      while j < a_len and k < b_len and a[j] == b[k]
        j += 1
        k += 1
      end

      n = k and break if j == a_len
    end

    n ||= 0

    a + b[n..b_len-1]
  end

  # Sanitizes a string and leaves behind only ascii characters, and gets rid of non-ascii and does not change original encoding
  def ascii_only!
    original_encoding = self.encoding
    encode!("US-ASCII", invalid: :replace, undef: :replace, replace: "")
    encode!(original_encoding.name)
  end

  # Removes matched portion from string and returns matched data object
  def extract!(regexp, &block)
    raise ArgumentError, "Must pass in a Regexp object!" unless regexp.is_a? Regexp


    match = regexp.match(self)

    if match
      sub!(regexp, "")

      if block_given?
        block.call(match)
      else
        return match
      end
    end

    nil
  end
end