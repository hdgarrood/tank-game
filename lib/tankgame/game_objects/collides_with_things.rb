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
        # changes @x and @y based on current @xspeed and @yspeed until +self+
        # is no longer colliding with any instances of the collision classes
        def do_collision_logic
          self.class.collision_classes.each do |klass|
            # if colliding with something
            if (collisions = collisions_with(klass)).any?
              # move back to where we were at the start of this tick
              @y -= @yspeed
              @x -= @xspeed
              search_lower, search_higher = 0.0, 1.0
              # TODO: refactor so that this doesn't happen more than necessary
              10.times do
                search_factor = (search_lower + search_higher) / 2
                pretend_x = @x + (@xspeed * search_factor)
                pretend_y = @y + (@yspeed * search_factor)

                pretending_to_be_at(pretend_x, pretend_y) do
                  if collisions.any? { |c| overlap?(c) }
                    search_higher = search_factor
                  else
                    search_lower = search_factor
                  end
                end
              end
              # change xspeed and yspeed so that they reflect the object's
              # actual new speed
              @xspeed *= search_lower
              @yspeed *= search_lower

              # finally, move as far as we are able to
              @x += @xspeed
              @y += @yspeed
            end
          end 
        end
      end
    end
  end
end
