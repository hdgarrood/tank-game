require 'gosu'

module TankGame
  class ResourceManager
    attr_reader :sprites
    IMAGE_PATH = "images/*.png"

    def initialize(window, path = "resource")
      @window = window
      @sprites = {} 

      Dir[File.join(path, IMAGE_PATH)].each do |file|
        sprite_name = File.basename(file, ".png")
        @sprites[sprite_name] = Gosu::Image.new(@window, file, false)
      end
    end
  end
end
