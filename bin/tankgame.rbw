#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'tankgame'

if __FILE__ == $0
  # change to the game's root dir
  Dir.chdir File.expand_path('../..', __FILE__)
  $window = TankGame::MainWindow.new
  $window.show
end

