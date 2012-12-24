module TankGame
  module GameObjects
    module CollidesWithThings
      def self.included(base)
        base.send(:extend, ClassMethods)
        base.send(:include, InstanceMethods)
      end

      module ClassMethods
        attr_reader :collision_classes
        # tells +self+ to check for collisions with instances of +klass+ on each
        # call to +do_collision_logic+
        def register_collision_class(klass)
          @collision_classes ||= []
          @collision_classes << klass
        end
      end

      module InstanceMethods
        # changes @x, @y, @xspeed, and @yspeed until +self+ is no longer
        # colliding with any instances of the collision classes
        def do_collision_logic
          self.class.collision_classes.each do |klass|
            # if colliding with something
            if (collisions = collisions_with(klass)).any?
              # move back to where we were at the start of this tick
              @y -= @yspeed
              @x -= @xspeed
              begin
                # slowly move towards the objects until we touch one again
                @x += x_direction * collision_check_increment
                @y += y_direction * collision_check_increment
              end until collisions.any? { |c| overlap?(c) }
              # move back one step
              @x -= x_direction * collision_check_increment
              @y -= y_direction * collision_check_increment
            end
          end 
        end

        def collision_check_increment
          0.5
        end

        def x_direction
          @xspeed <=> 0
        end

        def y_direction
          @yspeed <=> 0
        end
      end
    end
  end
end
