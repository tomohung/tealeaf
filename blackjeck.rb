# 1. initialize card deck
# 2. random give player two cards
# 3. random give host two cards
# 4. player choose 1.hit, draw a card. 2. pass, do nothing

# special: "A" could be 1 or 11
# if host and player' number are equal, compare with biggest number, or number is equal, compare with SYMBOLS

# 5. player win if blackjack = 21, lose if total > 21
# 6. host draw a card if total < 17, or total < user's total
# 7. host win if blackjack = 21, lose if total > 21
# 8. play again?

require 'pry'

CARDS = { "A" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7,
          "8" => 8, "9" => 9, "10" => 10, "J" => 10, "Q" => 10, "K" => 10}
SYMBOLS = {"♣" => 0, "♦" => 1, "♥" => 2, "♠" => 3}

def say(message)
  puts "=> #{message}"
end

def get_deck(pokers_count = 1)
  deck = []
  pokers_count.times do 
    SYMBOLS.keys.each do |symbol|
      CARDS.keys.each do |card|
        deck.push([symbol, card])
      end
    end

  end
  return deck
end

def draw_card(deck)
  card = deck.sample
  deck.delete(card)
end

def game_start(deck, player, host)
  2.times do
    player << draw_card(deck)
    host << draw_card(deck)
  end
end

def show_desk_card(player, host)
  system("clear")
  puts "------------- [DECK] --------------"
  puts "    Player's    vs    Host's"
  count = [player.count, host.count].max

  count.times do |index|
    player_card = index < player.count ? player[index] : ""
    host_card = index < host.count ? host[index] : ""

    puts "   #{player_card}        #{host_card}"
  end
end

def ask_player_hit(deck, player)

end

def ask_host_hit(deck, host)

end

def compare_result(player, host)
  return "Player"
end


system("clear")
say "Welcom to Tomo's Black Jack Game"
puts "" 
say "press ANY key to start..."
gets

begin
  deck = get_deck(1)
  player = []
  host = []

  game_start(deck, player, host)
  show_desk_card(player, host)

  ask_player_hit(deck, player)

  ask_host_hit(deck, host)

  winner = compare_result(player, host)

  say "#{winner} Win!"
  puts ""
  say "Play again? (y/n)"
end while gets.chomp.downcase == 'y'