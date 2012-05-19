require 'gosu'
require 'tankgame/game_objects'

module TankGame
  class ResourceManager
    RESOURCE_PATH = "resource/"
    IMAGE_PATH = "images/*.png"

    def load_sprites
      sprites = {} 

      Dir[File.join(RESOURCE_PATH, IMAGE_PATH)].each do |file|
        sprite_name = File.basename(file, ".png")
        sprites[sprite_name.to_sym] = Gosu::Image.new($window, file, false)
      end
      return sprites
    end

    def sprites
      @sprites ||= load_sprites
    end
  end
end
