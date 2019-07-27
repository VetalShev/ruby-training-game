require './player'

class Human < Player

  def attack
    rand(2..5)
  end

  def special_attack
    rand(2..5) * 2
  end

end

