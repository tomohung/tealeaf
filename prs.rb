# Paper, Rock, Scissors

puts "Game: Paper Rock Scissors"
puts "--------------------------"

prs = ["P", "R", "S"]
prs_fullname = ["Paper", "Rock", "Scissors"]

begin
  puts "Choose one P)Paper, R)Rock, S)Scissors"
  user_input = gets.chomp.upcase
  user_input_index = prs.index(user_input)
  
  if user_input_index == nil
    puts "[Error] Choose again."
    redo
  end

  computer_input_index = rand(2)

  puts "You: #{prs_fullname[user_input_index]} vs Computer: #{prs_fullname[computer_input_index]}"

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