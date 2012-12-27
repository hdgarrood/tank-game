#!/usr/bin/env ruby
$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
require 'tankgame/runner'

if $DEBUG
  TankGame.run_debug
else
  TankGame.run
end
