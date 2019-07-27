require './player'

class Monster < Player

  def attack
    rand(1..6)
  end

end