require 'pry'

module TicTacToeRuler
  THREE_LINE_SET = [[1, 2, 3], [4, 5, 6], [7, 8, 9], 
                    [1, 4, 7], [2, 5, 8], [3, 6, 9], 
                    [1, 5, 9], [3, 5, 7]]

  PICK_NUMBERS = (1..9).to_a
end


class Player

  attr_accessor :name, :picked_numbers

  def initialize(name)
    @name = name
    @picked_numbers = []
  end

  def get_straight_number?
    TicTacToeRuler::THREE_LINE_SET.each do |set|
      result = 0
      set.each do |number|
        if picked_numbers.include?(number)
          result += 1
        end
      end
      return true if result == set.size
    end
    return false
  end

  def pick
    gets.chomp.to_i
  end

  def add(number)
    self.picked_numbers << number
  end

end

class Robot_Player < Player

end

class TicTacToeBoard

  attr_accessor :unpicked_numbers, :user1, :user2, :current_user

private
  def initialize(player1, player2)
    self.unpicked_numbers = TicTacToeRuler::PICK_NUMBERS
    self.user1 = player1
    self.user2 = player2
    self.current_user = player1
  end
  
  def output_who_picked(value)
    case value
    when user1.picked_number.include?(value)
      'x'
    when user2.picked_number.include?(value)
      'o'
    else
      ' '
    end
  end  

public

  def ask_player_to_pick
    number = self.current_user.pick
    return false if !unpicked_numbers.include?(number)
    unpicked_numbers.delete(number)
    self.current_user.add(number)
    self.current_user = self.current_user == user1 ? user2 : user1
  end

  def show_figure

    if unpicked_numbers.size == TicTacToeRuler::PICK_NUMBERS.size
      puts "
       1 | 2 | 3
      ---+---+---
       4 | 5 | 6
      ---+---+---
       7 | 8 | 9
      "
      return
    end

    puts "
       #{output_who_picked(1)} | #{output_who_picked(2)} | #{output_who_picked(3)}  
      ---+---+---
       #{output_who_picked(4)} | #{output_who_picked(5)} | #{output_who_picked(6)}  
      ---+---+---
       #{output_who_picked(7)} | #{output_who_picked(8)} | #{output_who_picked(9)}  
     "
  end

  def game_is_over?
    return "Tie Game" if unpicked_numbers.empty?
    return "#{user1.name}, you win!!" if user1.get_straight_number?
    return "#{user2.name}, you are the true hero!!" if user2.get_straight_number?
    return false
  end

end

class TicTacToeGame

  attr_accessor :game_board

  def initialize
    say "Game mode: 1) Single Play. 2)Two Players."
    mode = gets.chomp

    say "Hero, enter your name:"
    player1_name = gets.chomp
    player1_name = "Guest" if player1_name.empty?

    player1 = Player.new(player1_name)
    if mode == "2"
      say "Another Hero, enter your name: "
      player2_name = gets.chomp
      player2_name = "Anonymous" if player2_name.empty?
      player2 = Player.new(player2_name)
    else
      say "#{player1_name}, come to beat Super Tomo!!"
      player2 = Robot_Player.new("Super Tomo")
    end

    self.game_board = TicTacToeBoard.new(player1, player2)
  end

  def say(message)
    puts "=> #{message}"
  end 

  def play

    loop do
      loop do
        system("clear")
        say "Welcome to Tomo's Tic-Tac-Toe Game" 
        game_board.show_figure
        
        say "-- #{game_board.current_user.name}'s turn --"
        say "Choose one number (1 ~ 9):"

        until !game_board.ask_player_to_pick
          say "Invalid Number..."
          sleep 1
        end

        result = game_board.game_is_over?
        break if result
      end

      system("clear")
      say "Result: "
      game_board.show_figure
      say result

      puts "\n"
      say "Play again? (y/n)"
      break if gets.chomp.downcase == 'y'
    end
  end
end

game = TicTacToeGame.new.play
puts "Exit Tic-Tac-Toe Game"
