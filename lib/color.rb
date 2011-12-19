##
# A color that can be represented as rgba, hsla, or hex.
class Color
  attr_accessor :hue, :saturation, :level, :alpha
  private
  def initialize(h, s, l, a=1)
    @hue = h
    @saturation = s
    @level = l
    @alpha = a
  end

  public
  def self.hsla(h, s, l, a)
    Color.new(h, s, l, a)
  end

  def self.hsl(h, s, l)
    self.hsla(h, s, l, 1)
  end

  def self.rgba(r, g, b, a)

  end

  def self.rgb(r, g, b)
    self.rgba(r, g, b, 1)
  end

  def self.hex(hex)

  end

  # Conversitons

  ##
  # Converts the given rgb values to equivalent hsl values.
  # 
  # *Note:* Values should be in the range of 0 to 255 and not percentages.
  def self.rgb_to_hsl(r, g, b)
    r, g, b = r % 255, g % 255, b % 255

    max = [r, g, b].max
    min = [r, g, b].min

    h = s = l = (min + max) / 2

    if min == max
      h  = s = 0;
    else
      d = max - min
      s = l > 0.5 ? d / (2 - max - min) : d / (max + min)
      case max
      when r
        h = (g - b) / d + (g < b ? 6 : 0)
      when g
        h = (b - r) / d + 2
      when b
        h = (r - g) / d + 4
      end
      h = h / 6
    end

    [h, s, l]
  end
end
