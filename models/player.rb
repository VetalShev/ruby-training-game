class Player

  attr_accessor :name
  attr_accessor :lives

  def initialize(name, lives)
    @name = name
    @lives = lives
  end

  def attack
    rand(1..5)
  end

end