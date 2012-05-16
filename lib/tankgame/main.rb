require 'gosu'
require 'tankgame/finite_state_machine'
require 'tankgame/resource_manager'

module TankGame
  class MainWindow < Gosu::Window
    attr_reader :fsm, :resources

    def initialize
      super(640, 480, false)
      self.caption = "hello world"
      @fsm = FiniteStateMachine.new(self)
      @resources = ResourceManager.new(self)
    end

    def update
      @fsm.update
    end

    def draw
      @fsm.draw
    end
  end
end

