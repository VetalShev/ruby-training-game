require './game_state'

class Game

  @state = nil
  @score = nil
  @player1 = nil
  @player2 = nil
  @first_move = nil
  @prev_move = nil

  @@total_games_count = 0

  def initialize player1, player2
    @player1 = player1
    @player2 = player2
    @state = Game_state::NEW
  end

  def start
    @state = Game_state::IN_PROGRESS
    puts "THE NEW GAME HAS STARTED!"
    
    puts "Enter the name of the first player"
    determine_first_move_player

    puts "Start the battle!"
    battle
  end

  def quit
    @state = Game_state::TERMINATED
    Game.increase_game_count
    puts "THE GAME HAS TERMINATED!"
    exit
  end

  def resume
    @state = Game_state::IN_PROGRESS
    puts "THE GAME RESUMED!"
  end

  def finish
    @state = Game_state::FINISHED
    Game.increase_game_count
    puts "THE GAME FINISHED!"
  end

  def battle
    current_player = @first_move
    @prev_move = @first_move == @player1 ? @player1 : @player2

    while @player1.lives > 0 && @player2.lives > 0 do
      puts "Move of the player #{current_player.name}.\nLives: #{current_player.lives}\nType \"Enter\" to attack or \"quit\" to exit the game"

      command = gets.chomp

      if quit_the_game? command
        quit
      end

      attack current_player
      @prev_move = current_player
      current_player = @prev_move == @player1 ? @player2 : @player1
      puts "================"
      puts "================"
    end
    
    puts "#{current_player.name} win! Congratulations!"
    finish
  end

  def quit_the_game?(input)
    input.to_s == "quit"
  end

  def is_first_player(player)
    player == @player1
  end

  def attack(current_player)
      player_to_be_attacked = is_first_player(current_player) ? @player2 : @player1

      lives_count = current_player.attack
      player_to_be_attacked.lives = player_to_be_attacked.lives - lives_count

      puts "Player #{current_player.name} hits #{player_to_be_attacked.name} with damage #{lives_count}.\n#{player_to_be_attacked.name} has #{player_to_be_attacked.lives} health left."
  end

  def determine_first_move_player
    first_player_name = gets.chomp
    player = get_player_by_name(first_player_name)
    if player
      @first_move = player
    else
      puts "Wrong player name. Type the name one more time please"
      determine_first_move_player
    end
    
  end

  def get_player_by_name(name)
    if @player1.name.to_s == name.to_s
      return @player1
    elsif @player2.name.to_s == name.to_s
      return @player2
    else 
      return nil
    end
  end

  def self.increase_game_count
    @@total_games_count = @@total_games_count + 1
  end

end