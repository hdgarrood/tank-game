module TankGame
  module GameObjects
    class Block < BaseObject
      def initialize(x, y)
        super(x, y)
        @sprite = Resources.sprites[:block]
      end

      def width
        32
      end

      def height
        32
      end
    end
  end
end
