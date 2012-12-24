require 'gosu'
require 'tankgame/game_objects'

module TankGame
  module Resources
    class << self
      def sprites
        @sprites ||= load_sprites
      end

      private
      def load_sprites
        sprites = {}
        Dir['resource/images/*.png'].each do |file|
          sprites[File.basename(file, ".png").to_sym] =
            Gosu::Image.new($window, file, false)
        end
        sprites
      end
    end
  end
end
