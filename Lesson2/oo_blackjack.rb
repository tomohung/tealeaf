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
    cards.each {|card| value += BlackJackRuler::CARD[card[1]]}
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
end

class Dealer < Player
  def forced_to_hit?
    get_score < 17
  end
end

class Cards
  attr_reader :cards

  def initialize(poker_count = 1)
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
    @dealer.clear
    @cards = Cards.new
    @players.each {|player| player.clear}
  end

  def show
    system("clear")
    puts "<-----------  [ DECK ]  ------------>"
    
    print "%8s" % dealer.name
    players.each do |player|
      print "%8s" % player.name
    end
    puts ""

    count = 0
    players.each do |player| 
      if player.cards.size > count 
        count = player.cards.size
      end
    end

    count.times do |index|
      print "%8s" % dealer.cards[index].to_s
      players.each {|player| print "%8s" % player.cards[index].to_s}
    end

    puts ""
    print "%8d" % dealer.get_score
    player.each {|player| print "%8d" % player.get_score}

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
    players_count.times do |index|
      say "No.#{index + 1} Player's name:"
      player_name = gets.chomp 
      player_name = "Player#{index + 1}" if player_name.empty?
      @players << Player.new(player_name)
    end
  end

  def play
    loop do
      self.reset
      deck.show
      #deal_initial_cards_to_everyone
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

