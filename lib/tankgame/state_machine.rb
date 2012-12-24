require 'gosu'

module TankGame
  module StateMachine
    attr_reader :current_state
    attr_writer :next_state

    def change_state
      if @next_state
        @current_state, @next_state = @next_state, nil
      end
    end
  end
end

