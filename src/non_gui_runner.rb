require File.dirname(__FILE__) + "/game"

game = Game.new
100.times { game.tick }