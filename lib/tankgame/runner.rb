require 'tankgame/main_window'

module TankGame
  class << self
    def run
      $window = MainWindow.new
      $window.show
    end

    # debugging
    def run_debug
      require 'tankgame/watches_window'
      add_main_window_hook
      $watches_window = WatchesWindow.new
      $watches_window.watch do
        $window.current_state.
          instance_variable_get("@objects").
          select { |a| a.is_a? GameObjects::Player }.
          first
      end
      $watches_window.show
      run
    end

    private
    def add_main_window_hook
      MainWindow.class_eval do
        alias_method :update_without_debug, :update
        def update
          update_without_debug
          $watches_window.update unless $watches_window.destroyed?
          require 'debugger'; debugger if button_down?(Gosu::Kb1)
        end
      end
    end
  end
end
