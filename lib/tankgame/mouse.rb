module TankGame
  module Mouse
    class << self
      def x
        $window.mouse_x
      end

      def y
        $window.mouse_y
      end
    end
  end
end
