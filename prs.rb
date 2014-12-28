# Paper, Rock, Scissors

PRS_SET = {"P" => "Paper", "R" => "Rock", "S" => "Scissors"}
PRS_SET_INDEX = {"P" => 1, "R" => 2, "S" => 3} 

begin
  system("clear")
  puts "Game: Paper Rock Scissors"
  puts "--------------------------"

  puts "Choose one P)Paper, R)Rock, S)Scissors"
  user_input = gets.chomp.upcase
  
  if PRS_SET.has_key?(user_input) == false
    puts "[Error] Choose again."
    redo
  end

  computer_input = PRS_SET.keys.sample 

  puts "You: #{PRS_SET[user_input]} vs Computer: #{PRS_SET[computer_input]}"

  user_input_index = PRS_SET_INDEX[user_input]
  computer_input_index = PRS_SET_INDEX[computer_input] 

  case 
  when user_input_index == computer_input_index
    puts "Even."
  when user_input_index - computer_input_index == -1 || user_input_index - computer_input_index == 2
    puts "You Win!!"
  else
    puts "You Lose."
  end

  puts "Play again? Y) Yes to Continue. N) Any key to exit."
end while gets.chomp.upcase == "Y"