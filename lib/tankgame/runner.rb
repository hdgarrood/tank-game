require 'tankgame/main_window'

module TankGame
  def self.run
    $window = MainWindow.new
    $window.show
  end
end
