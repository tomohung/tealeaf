# noun: player, dealer, deck, cards
# verb: set users count, random cards, 
#   deal cards, check cards point, show deck, ask hit/stay

module BlackJackRuler
  CARDS = { 
    "A" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7,
    "8" => 8, "9" => 9, "10" => 10, "J" => 10, "Q" => 10, "K" => 10
    }.freeze

  SUITES = { "Club" => "♣", "Square" => "♦", "Heart" => "♥", "Spade" => "♠"}.freeze
  BLACKJACK = 21.freeze
end

class Player
  attr_accessor :cards
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_score
    value = 0
    cards.each {|card| value += BlackJackRuler::CARDS[card[1]]}
    has_card_A = !cards.select {|card| card[1] == "A"}.empty?
    return value unless has_card_A
    value + 10 > BlackJackRuler::BLACKJACK ? value : value + 10
  end

  def blackjack?
    score = get_score
    score == BlackJackRuler::BLACKJACK
  end

  def busted?
    get_score > BlackJackRuler::BLACKJACK
  end

  def get_card(card)
    @cards << card
  end

  def reset
    @cards = []
  end

  def hit?
    puts "Hit or Stay (y/n):"
    gets.chomp.downcase == 'y'
  end
end

class RobotPlayer < Player
  def hit?
    get_score < 17
  end
end

class Dealer < RobotPlayer
end

class Cards
  attr_reader :cards

  def initialize(poker_count = 1)
    @cards = []
    poker_count.times do 
      BlackJackRuler::SUITES.values.each do |suite|
        BlackJackRuler::CARDS.keys.each do |card|
          @cards.push([suite, card])
        end
      end
    end
    @cards.shuffle!
  end

  def deal_a_card(player)
    player.cards << @cards.pop
  end
end

class Deck
  attr_accessor :dealer, :players, :cards
  def initialize(players)
    @players = players
    @dealer = Dealer.new("Dealer Tomo")
    @cards = Cards.new
  end

  def reset
    @dealer.reset
    @cards = Cards.new
    @players.each {|player| player.reset}
    deal_initial_cards_to_everyone
  end

  def deal_initial_cards_to_everyone
    2.times do 
      players.each do |player|
        cards.deal_a_card(player)
      end
      cards.deal_a_card(dealer)
    end
  end

  def show(hidden_card = true)
    system("clear")
    puts "<-----------  [ DECK ]  ------------>"
    
    format_string = "%16s"
    print format_string % dealer.name
    players.each do |player|
      print format_string % player.name
    end
    puts ""

    count = dealer.cards.size
    players.each do |player| 
      if player.cards.size > count 
        count = player.cards.size
      end
    end

    count.times do |index|
      if index == 1 && hidden_card
        print format_string % "*hidden*"
      else
        print format_string % dealer.cards[index].to_s
      end

      players.each do |player| 
        print format_string % player.cards[index].to_s
      end
      puts ""
    end

    puts "\n"
    print format_string % (hidden_card ? "" : dealer.get_score)
    players.each {|player| print format_string % player.get_score}

    puts "\n"
    puts "<----------------------------------->"
  end

end

class BlackJackGame
  attr_accessor :deck, :players

  def initialize
    create_players
    @deck = Deck.new(@players)
  end

  def say(message)
    puts "=> #{message}"
  end

  def create_players
    @players = []
    say "Players count: (1 ~ 4)"
    players_count = gets.chomp.to_i until (1..4).include?(players_count)
    
    say "Player's name:"
    player_name = gets.chomp
    player_name = "Player" if player_name.empty?
    @players << Player.new(player_name)

    (players_count - 1).times do |index|
      player_name = "PC.#{index + 1}"
      @players << RobotPlayer.new(player_name)
    end
  end

  def play
    loop do
      self.reset
      
      deck.show

      deck.deal_initial_cards_to_everyone


      #ask_player_hit_or_stay
      #ask_dealer_hit_or_stay

      say "Play again? (y/n)"
      break if gets.chomp.downcase == 'n'
    end
  end

  def reset
    @deck.reset
  end


end

BlackJackGame.new.play

