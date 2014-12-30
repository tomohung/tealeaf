# Tic Tac Toe Game

# 1. print squares 
# 2. user select square 
# 3. computer select square (smarter choice)
# 4. show result if game is over
# 5. play again?

THREE_LINE_SET = [[1, 2, 3], [4, 5, 6], [7, 8, 9], 
                  [1, 4, 7], [2, 5, 8], [3, 6, 9], 
                  [1, 5, 9], [3, 5, 7]]
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

  if input_hash.empty?
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
      say "Index #{input} Has been choosen!"
      redo
    end

    input_hash[input.to_i] = USER_PICK
  end until input_hash[input.to_i]
end

def get_winning_score(input_hash, set, index, role)
  score = 0
  set.each do |element|
    if element == index
      score += role
    elsif input_hash[element].nil?
      next
    else
      score += input_hash[element]
    end
  end
  return score
end

def pick_number_to_win(input_hash, role)
  (1..9).to_a.each do |index|
    if input_hash[index].nil?
      THREE_LINE_SET.each do |set|
        if set.include?(index)
          score = get_winning_score(input_hash, set, index, role)
          return index if score == 3 * role
        end
      end
    end
  end
  return 0 #if there is no any match
end

def get_possible_winning_score(input_hash, set, role)
  score = 0
  set.each do |element|
    if input_hash[element].nil?
      score += role
    else
      score += input_hash[element]
    end
  end
  return score
end

def retrieve_possible_winning_number(result_hash, role)
  last_result = 0
  choose_number = 0
  result_hash.each do |key, value|
    if value * role > last_result
      last_result = value
      choose_number = key
    end
  end
  return choose_number
end  

def pick_number_to_possible_win(input_hash, role)
  result_hash = {}
  (1..9).to_a.each do |index|
    result = 0
    
    if input_hash[index].nil?
      THREE_LINE_SET.each do |set|
        if set.include?(index)
          set.each do |element|
            input_hash[element].nil? ? result += role : result += input_hash[element]
          end
        end
      end
      result_hash[index] = result
    end
  end 
  return retrieve_possible_winning_number(result_hash, role)
end

def computer_pick_square(input_hash)
  
  choose_number = 0

  # 1. pick number to let computer get a straight line
  choose_number = pick_number_to_win(input_hash, COMPUTER_PICK)
  if choose_number > 0
    input_hash[choose_number] = COMPUTER_PICK
    return 
  end
  
  # 2. pick number to prevent user get a straight line
  choose_number = pick_number_to_win(input_hash, USER_PICK)

  if choose_number > 0
    input_hash[choose_number] = COMPUTER_PICK
    return 
  end

  # 3. pick number to prevent user get a maximum possible win
  choose_number = pick_number_to_possible_win(input_hash, USER_PICK)
  if choose_number > 0
    input_hash[choose_number] = COMPUTER_PICK
    return
  end

  # 4. pick number to let computer get a maximum possible win
  choose_number = pick_number_to_possible_win(input_hash, COMPUTER_PICK)
  input_hash[choose_number] = COMPUTER_PICK
end

def game_is_over?(input_hash)
  unchoosen_array = (1..9).to_a.select {|number| input_hash[number].nil? }
  return TIE_GAME if unchoosen_array.empty?

  THREE_LINE_SET.each do |set|
    
    result = 0
    set.each do |number|
      if input_hash.has_key?(number)
        result += input_hash[number]
      end
      return USER_PICK if result == 3 * USER_PICK 
      return COMPUTER_PICK if result == 3 * COMPUTER_PICK
    end
  end
  return false
end

begin
  picked_record = {}
  begin
    system("clear")
    say "Welcome to Tomo's Tic-Tac-Toe Game" 
    show_tic_tac_toe_figure(picked_record)
    
    user_pick_square(picked_record)
    check_status = game_is_over?(picked_record)
    break if check_status

    computer_pick_square(picked_record)
    check_status = game_is_over?(picked_record)
  end until check_status

  system("clear")
  say "Result: "
  show_tic_tac_toe_figure(picked_record)
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