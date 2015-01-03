class Player

  PRS_SET = {"P" => "Paper", "R" => "Rock", "S" => "Scissors"}
  attr_reader :name, :decision

  def initialize(name)
    @name = name
    @name = "Guest" if name == "" 
    @decision = "P" 
  end

  def display_decision
    PRS_SET[decision]
  end

  def auto_make_decision
    @decision = PRS_SET.keys.sample
  end

  def set_decision(decision)
    return false unless PRS_SET.has_key?(decision)
    @decision = decision
  end

  def match_with(player)
    self_index = PRS_SET.keys.index(decision)
    player_index = PRS_SET.keys.index(player.decision)

    case 
    when self_index == player_index
      "It's a tie."
    when self_index - player_index == -1 || self_index - player_index == 2
      "You Win!!"
    else
      "Loser..."
    end
  end
end

puts "Enter Your Name:"
user_name = gets.chomp
user = Player.new(user_name)
computer = Player.new("Computer")

begin
  system("clear")
  puts "Hi, #{user.name}"
  puts "Welcome to Game: Paper Rock Scissors"
  puts "--------------------------"

  puts "Choose one P)Paper, R)Rock, S)Scissors"
  loop do 
    break if user.set_decision(gets.chomp.upcase)
    puts "Error! Invalid input."
  end

  computer.auto_make_decision

  puts "#{user.name}: #{user.display_decision} VS Computer: #{computer.display_decision}"
  puts user.match_with(computer)

  puts "Play again? (y/n)"
end while gets.chomp.downcase == 'y'

