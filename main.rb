require './game'
require './models/player'

humanPlayer = Player.new :Max, 30
monsterPlayer = Player.new :Creature, 25

game = Game.new humanPlayer, monsterPlayer
game.start