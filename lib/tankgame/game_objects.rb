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

    # used for collision detection. override to give a bouncing block
    def width
      @sprite.width
    end

    # used for collision detection. override to give a bouncing block
    def height
      @sprite.height
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
      @barrel_angle = 0.0
    end

    def handle_events
      # left/right motion
      if $window.button_down? Gosu::KbD
        @motion = :right
      elsif $window.button_down? Gosu::KbA
        @motion = :left
      else
        @motion = :none
      end
      
      # boosting
      if $window.button_down? Gosu::KbLeftShift
        @wants_to_boost = true
      else
        @wants_to_boost = false
      end

      # work out which direction the barrel wants to be pointing
      mouse_angle = Angle.new(Math.atan2($window.mouse_y - centre[1],
                                          $window.mouse_x - centre[0]))
      case mouse_angle.quadrant
      when :first
        @barrel_target = 0.0
      when :second
        @barrel_target = -Math::PI
      else
        @barrel_target = mouse_angle.angle
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
        @boost_timer = Countdown.new.start(boost_length)
        @boost_wait_timer = Countdown.new.start(boost_wait_length)
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

      # barrel direction
      barrel_difference = @barrel_angle - @barrel_target
      if barrel_difference.abs < barrel_rotate_speed
        @barrel_angle = @barrel_target
      elsif @barrel_angle < @barrel_target
        @barrel_angle += barrel_rotate_speed
      else
        @barrel_angle -= barrel_rotate_speed
      end
    end

    def draw
      barrel_direction = Angle.new(@barrel_angle).direction
      @barrel_sprite[barrel_direction].draw_rot(*centre, 0, @barrel_angle.radians_to_gosu + 270, 0)
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

    def barrel_rotate_speed
      0.1
    end

    # time in ms which a boost lasts
    def boost_length
      800
    end

    # time in ms between starting one boost and being able to start
    # another one
    def boost_wait_length
      10000
    end
  end
end

