require 'gosu'
require 'tankgame/countdown'
require 'tankgame/angle'

module TankGame
  class GameObject
    attr_reader :x, :y

    def initialize(x, y)
      @sprite = nil
      @x = x
      @y = y
    end

    def handle_events
    end

    def do_logic
    end

    def draw
      @sprite.draw(x, y, 0)
    end

    private

    # returns a list [x, y] of the co-ordinates of what looks like the
    # centre of the object (judging by the sprite)
    def centre
      [@x + (@sprite.width / 2), @y + (@sprite.height / 2)]
    end
  end


  class Block < GameObject
    def initialize(x, y)
      super(x, y)
      @sprite = $window.resources.sprites[:block]
    end
  end

  class Player < GameObject
    def initialize(x, y)
      super(x, y)
      @sprite = $window.resources.sprites[:player]
      @barrel_sprite = {
        :left => $window.resources.sprites[:barrel_left],
        :right => $window.resources.sprites[:barrel_right]
      }
      @xspeed = @yspeed = 0
      @boosting = false
      @boost_timer = nil
      @boost_wait_timer = nil
    end

    def handle_events
      if $window.button_down? Gosu::KbD
        @motion = :right
      elsif $window.button_down? Gosu::KbA
        @motion = :left
      else
        @motion = :none
      end
      
      if $window.button_down? Gosu::KbLeftShift
        @wants_to_boost = true
      else
        @wants_to_boost = false
      end
    end

    def do_logic
      # boosting
      if @boosting && @boost_timer.finished?
        @boosting = false
        @boost_timer = nil
      end

      if @wants_to_boost && can_boost?
        @boosting = true
        @boost_timer = Countdown.new.start(1000)
        @boost_wait_timer = Countdown.new.start(10000)
      end 

      
      # motion
      case @motion
      when :left
        @xspeed -= acceleration
      when :right
        @xspeed += acceleration
      end
      @x += @xspeed
      @y += @yspeed
      if @xspeed.nonzero?
        # friction reduces the player's speed
        @xspeed > 0 ? @xspeed -= friction : @xspeed += friction
      end
    end

    def draw
      barrel_angle = Angle.new(Math.atan2($window.mouse_y - @y,
                                          $window.mouse_x - @x))
      case barrel_angle.quadrant
      when :first
        # the mouse is below and to the right of the tank
        # the barrel points horizontally right
        @barrel_sprite[:right].draw(*centre, 0)
      when :second
        @barrel_sprite[:left].draw(centre[0] - @barrel_sprite[:left].width, centre[1], 0)
      else
      end
      super
    end

    private
    # returns the current highest possible acceleration for the player
    # (by means of the tank's engine) -- this should not be used for
    # gravity, etc.
    def acceleration
      if @boosting
        1.2
      else
        0.5
      end
    end

    # the amount the player should slow down each step if he stops
    # pressing buttons. returns absolute value
    def friction
      (@xspeed * 0.2).abs
    end

    def can_boost?
      @boost_wait_timer.nil? or
      @boost_wait_timer.finished?
    end
  end
end

