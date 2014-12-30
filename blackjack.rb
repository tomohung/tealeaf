# 1. initialize card deck
# 2. random give player two cards
# 3. random give host two cards
# 4. player choose 1.hit, draw a card. 2. pass, do nothing

# special: "A" could be 1 or 11

# 5. player win if blackjack = 21, lose if total > 21
# 6. host draw a card if total < 17, or total < user's total
# 7. host win if blackjack = 21, lose if total > 21
# 8. if both host and player's score are <= 21, then compare host and player's score
# 9. play again?

require 'pry'

CARDS = { "A" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7,
          "8" => 8, "9" => 9, "10" => 10, "J" => 10, "Q" => 10, "K" => 10}
SUITES = {"♣" => 0, "♦" => 1, "♥" => 2, "♠" => 3}

BLACKJACK = 21


def say(message)
  puts "=> #{message}"
end

def get_deck(pokers_count = 1)
  deck = []
  pokers_count.times do 
    SUITES.keys.each do |symbol|
      CARDS.keys.each do |card|
        deck.push([symbol, card])
      end
    end
  end
  deck
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

def get_score(cards)
  score = 0
  has_card_a = false
  cards.each do |card|
    if card[1] == "A" && !has_card_a
      has_card_a = true
    else
      score += CARDS[card[1]]
    end
  end

  if has_card_a
    return BLACKJACK if score == 10
    score += 1
  else
    score
  end
  score
end

def show_desk_card(player, host, display_host_card = true)
  system("clear")
  puts "-------------[ DECK ]--------------"
  puts "    Player's    vs    Host's"
  count = [player.count, host.count].max

  count.times do |index|
    player_card = index < player.count ? player[index] : "          "
    
    host_card = index < host.count ? host[index] : "          "
    host_card = "* hidden *" if !display_host_card && index == 0

    puts "   #{player_card}        #{host_card}"
  end

  player_score = get_score(player)
  host_score = display_host_card ? get_score(host) : ""
  puts ""
  puts "       #{player_score}            #{host_score}"
  puts "------------------------------------"
end

def check_busted?(cards)
  score = get_score(cards)
  score > BLACKJACK
end

def ask_player_hit(deck, player, host)
  begin
    show_desk_card(player, host, false)
    return false if get_score(player) == BLACKJACK

    say "Player's turn: "
    puts ""
    say "Hit ? (y/n)"
    input = gets.chomp.downcase
    
    if input == 'y'
      player << draw_card(deck)
      return false if check_busted?(player) 
    end

  end while input == 'y'
  true
end

def host_need_draw_card?(deck, player, host)

  player_score = get_score(player)
  return false if player_score > BLACKJACK
  
  host_score = get_score(host)
  return false if host_score > BLACKJACK
  
  host_score < player_score || host_score < 17

end

def ask_host_hit(deck, player, host)
  begin
    show_desk_card(player, host)

    say "Host's turn: "
    puts ""
    say "Press [RETURN] to continue..."
    gets

    return if !host_need_draw_card?(deck, player, host)
    host << draw_card(deck) 
  end until check_busted?(host)

end

def compare_result(player, host)
  return "You can do better..." if check_busted?(player)
  return "Player win!" if check_busted?(host)

  player_score = get_score(player)
  host_score = get_score(host)

  return "GAME is tie" if player_score == host_score
  player_score > host_score ? "Player Win!" : "You're Loser..."
end


system("clear")
say "Welcom to Tomo's Black Jack Game"
puts "" 
say "press [RETURN] key to start..."
gets


begin
  deck = get_deck(1)
  player = []
  host = []

  game_start(deck, player, host)

  continue = ask_player_hit(deck, player, host)
  ask_host_hit(deck, player, host) if continue

  result = compare_result(player, host)

  show_desk_card(player, host)
  say "#{result}"
  puts ""
  say "Play again? (y/n)"
end while gets.chomp.downcase == 'y'