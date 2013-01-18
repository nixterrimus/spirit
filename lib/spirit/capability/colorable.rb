module Capability
  module Colorable
    def red=(red)
      @red = red
    end

    def green=(green)
      @green = green
    end

    def blue=(blue)
      @blue = blue
    end

    def red
      @red
    end

    def green
      @green
    end

    def blue
      @blue
    end

    def color(hex)
      #
    end


    def default_color
      self.red(0)
      self.green(0)
      self.blue(0)
    end
  end
end
