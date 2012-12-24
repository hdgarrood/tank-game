require 'gosu'
require 'tankgame/states'
require 'tankgame/state_machine'

module TankGame
  class MainWindow < Gosu::Window
    include StateMachine

    def initialize
      super(640, 480, false)
      self.caption = "hello world"
    end

    def show
      @current_state = States::Game.new
      super
    end

    def update
      current_state.update
      change_state
    end

    def draw
      current_state.draw
    end
  end
end

