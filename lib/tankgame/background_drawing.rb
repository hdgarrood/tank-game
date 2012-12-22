require 'gosu'

module TankGame
  module BackgroundDrawing
    # draws the background on the passed instance of Gosu::Window, 
    # with a gradient going from #top_colour to #bottom_colour
    def draw_background(window)
      window.draw_quad(
        0, 0, top_colour,
        window.width, 0, top_colour,
        0, window.height, bottom_colour,
        window.width, window.height, bottom_colour,
        0
      )
    end

    private
    def top_colour
      Gosu::Color.argb(0xfff0f0f0)
    end

    def bottom_colour
      Gosu::Color.argb(0xff6b6b6b)
    end
  end
end
