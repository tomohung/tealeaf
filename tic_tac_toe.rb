# Tic Tac Toe Game

# 1. print squares 
# 2. user select square 
# 3. computer select square (smarter choice)
# 4. show result if game is over
# 5. play again?

require 'pry'

def output(hash_value)
  case hash_value
  when 0
    'x'
  when 1
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
    puts "Choose one square (1 ~ 9): "
    input = gets.chomp
    result = input =~ /[1-9]/

    if !result
      puts "Please input 1 ~ 9"
      redo
    end

    if input_hash[input.to_i]
      puts "Has Choosen!"
      redo
    end

    input_hash[input.to_i] = 0
  end until input_hash[input.to_i]
end

def computer_pick_square(input_hash)
  (1..9).to_a.each do |x|
    if input_hash[x] == nil
      input_hash[x] = 1
      break
    end
  end 
end

def game_is_over?(input_hash)
  unchoosen_index = (1..9).to_a.select {|x| input_hash[x].nil? }
  if unchoosen_index.count == 0
    puts "It's tie..."
    return true
  end 

  return false

end


begin
  squares_hash = {}
  loop do
    system("clear")
    puts "Welcome to Tomo's Tic-Tac-Toe Game" 
    show_tic_tac_toe_figure(squares_hash)
    
    user_pick_square(squares_hash)
    computer_pick_square(squares_hash)

  end until game_is_over?(squares_hash)

  puts "Play again? (y/n)"
end while gets.chomp.downcase == 'y'

puts "Exit Tic-Tac-Toe Game"