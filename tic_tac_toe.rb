# Tic Tac Toe Game

# 1. print squares 
# 2. user select square 
# 3. computer select square (smarter choice)
# 4. show result if game is over
# 5. play again?

require 'pry'

THREE_LINE_SET = [[1, 2, 3],[4, 5, 6],[7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
COMPUTER_PICK = -1
USER_PICK = 1
TIE_GAME = 0

def say(message)
  puts "=> #{message}"
end

def output(hash_value)
  case hash_value
  when USER_PICK
    'x'
  when COMPUTER_PICK
    'o'
  else
    ' '
  end
end

def show_tic_tac_toe_figure(input_hash)

  if input_hash.count == 0
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
     #{output(input_hash[1])} | #{output(input_hash[2])} | #{output(input_hash[3])}  
    ---+---+---
     #{output(input_hash[4])} | #{output(input_hash[5])} | #{output(input_hash[6])}  
    ---+---+---
     #{output(input_hash[7])} | #{output(input_hash[8])} | #{output(input_hash[9])}  
   "
end

def user_pick_square(input_hash)
  
  begin
    say "Choose one square (1 ~ 9): "
    input = gets.chomp
    result = input =~ /[1-9]/

    if !result
      say "Please input 1 ~ 9"
      redo
    end

    if input_hash[input.to_i]
      say "#{input} Has Choosen!"
      redo
    end

    input_hash[input.to_i] = USER_PICK
  end until input_hash[input.to_i]
end

def computer_pick_square(input_hash)
  (1..9).to_a.each do |x|
    if input_hash[x] == nil
      input_hash[x] = COMPUTER_PICK
      break
    end
  end 
end

def game_is_over?(input_hash)
  unchoosen_array = (1..9).to_a.select {|x| input_hash[x].nil? }
  return TIE_GAME if unchoosen_array.empty?

  result = nil
  THREE_LINE_SET.each do |set|
    
    result = 0
    set.each do |x|
      if input_hash.has_key?(x)
        result += input_hash[x]
      end
      return USER_PICK if result == 3 
      return COMPUTER_PICK if result == -3
    end
  end

  return false

end

begin
  squares_hash = {}
  begin
    system("clear")
    say "Welcome to Tomo's Tic-Tac-Toe Game" 
    show_tic_tac_toe_figure(squares_hash)
    
    user_pick_square(squares_hash)
    check_status = game_is_over?(squares_hash)
    break if check_status

    computer_pick_square(squares_hash)
    check_status = game_is_over?(squares_hash)
  end until check_status

  system("clear")
  say "Result: "
  show_tic_tac_toe_figure(squares_hash)
  case check_status
  when TIE_GAME
    say "It's tie"
  when USER_PICK
    say "You Win!!"
  when COMPUTER_PICK
    say "Computer Win!!"
  end  

  puts "\n"
  say "Play again? (y/n)"
end while gets.chomp.downcase == 'y'

say "Exit Tic-Tac-Toe Game"