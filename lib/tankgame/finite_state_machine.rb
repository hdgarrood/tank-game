require 'gosu'
require 'tankgame/game_states'

module TankGame
  class FiniteStateMachine
    attr_reader :current_state
    attr_writer :next_state

    public
    def initialize
      @current_state = State::Game.new
      @next_state = nil
    end

    def update
      change_state_if_needed
      current_state.update
    end

    def draw
      current_state.draw
    end

    private
    def change_state_if_needed
      unless @next_state.nil?
        @current_state = next_state.new
        @next_state = nil
      end
    end

  end
end

