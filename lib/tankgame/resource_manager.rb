require 'gosu'
require 'tankgame/game_objects'

module TankGame
  class ResourceManager
    def sprites
      @sprites ||= load_sprites
    end

    private
    def load_sprites
      sprites = {} 

      Dir['resource/images/*.png'].each do |file|
        sprite_name = File.basename(file, ".png")
        sprites[sprite_name.to_sym] = Gosu::Image.new($window, file, false)
      end

      return sprites
    end
  end
end
