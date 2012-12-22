require 'gosu'
require 'tankgame/resource_manager'
require 'tankgame/finite_state_machine'

module TankGame
  class MainWindow < Gosu::Window
    attr_reader :fsm, :resources

    def initialize
      super(640, 480, false)
      self.caption = "hello world"
    end

    def show
      @resources = ResourceManager.new
      @fsm = FiniteStateMachine.new
      super
    end

    def update
      @fsm.update
    end

    def draw
      @fsm.current_state.draw
    end
  end
end

