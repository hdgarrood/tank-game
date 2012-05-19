require 'gosu'
require 'tankgame/countdown'
require 'tankgame/geometry'

module TankGame
  class GameObject
    attr_accessor :x, :y

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

    # the object's physical width, used for collisions
    def width
      0
    end

    # the object's physical height, used for collisions
    def height
      0
    end

    # the distance (x) from @x to the top-left corner of the object's
    # bouncing box in pixels
    def offset_x
      0
    end

    # the distance (y) from @y to the top-left corner of the object's
    # bouncing box in pixels
    def offset_y
      0
    end

    # true if +self+ placed at +x+, +y+ would collide with an object
    # which is an object of class +klass+
    def place_meeting?(x, y, klass)
      $window.fsm.current_state.place_meeting?(self, x, y, klass)
    end

    # returns the top-left and bottom-right corner of the object,
    # dependent upon +offset_x+, +offset_y+, +width+, and +height+
    def two_corners
      x1 = @x + offset_x
      x2 = x1 + width
      y1 = @y + offset_y
      y2 = y1 + height
      return [[x1, y1], [x2, y2]]
    end

    # returns the co-ordinates of each corner of the object (dependent
    # upon +offset_x+, +offset_y+, +width+, and +height+) as a 4-element
    # array, with each element being a 2-element array, ie [[x1, y1],
    # [x1, y2], [x2,  y1], [x2, y2]]
    def four_corners
      c = two_corners
      return [
        c[0],
        [c[0][0], c[0][1]],
        [c[1][0], c[0][1]],
        c[1]
      ]
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

    def width
      32
    end

    def height
      32
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

