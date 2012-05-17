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

    def start
      @resources = ResourceManager.new
      @fsm = FiniteStateMachine.new
      return self
    end

    def update
      @fsm.update
    end

    def draw
      @fsm.draw
    end
  end
end

