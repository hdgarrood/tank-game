require 'gosu'
require 'tankgame/game_states'

module TankGame
  class FiniteStateMachine
    attr_reader :window

    public
    def initialize(window)
      @window = window
      @stack = [State::Game.new(window)]
      @next_state = nil
    end

    def update
      change_state_if_needed
      push_states
      current_state.update
    end

    def draw
      current_state.draw
    end

    def current_state
      @stack.last
    end

    def set_next_state(state)
      @next_state = state
    end

    def push_state(state)
      @push_state = state
    end

    private
    def change_state_if_needed
      unless @next_state.nil?
        @stack.pop
        @stack.push(@next_state.new(self.window))
        @next_state = nil
      end
    end

    def push_states
      unless @push_state.nil?
        @stack.push(@push_state.new(self.window))
      end
    end
  end
end

