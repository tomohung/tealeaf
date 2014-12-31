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

CARDS = { 
  "A" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7,
  "8" => 8, "9" => 9, "10" => 10, "J" => 10, "Q" => 10, "K" => 10
  }

SUITES = { "Club" => "♣", "Square" => "♦", "Heart" => "♥", "Spade" => "♠"}
BLACKJACK = 21

def say(message)
  puts "=> #{message}"
end

def get_deck(pokers_count = 1)
  deck = []
  pokers_count.times do 
    SUITES.values.each do |symbol|
      CARDS.keys.each do |card|
        deck.push([symbol, card])
      end
    end
  end
  deck.shuffle
end

def game_start(deck, player, host)
  2.times do
    player.push(deck.pop)
    host.push(deck.pop)
  end
end

def get_score(cards)
  score = 0
  keep_card_A_reserved = false

  cards.each do |card|
    if card[1] == "A" && !keep_card_A_reserved
      keep_card_A_reserved = true
    else
      score += CARDS[card[1]]
    end
  end

  return BLACKJACK if keep_card_A_reserved && (score + 11 == BLACKJACK)
  keep_card_A_reserved ? score + 1 : score
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
  loop do
    show_desk_card(player, host, false)
    return false if get_score(player) == BLACKJACK

    say "Player's turn: "
    puts ""
    say "Hit ? (y/n)"
    continue = gets.chomp.downcase == 'y'
    
    if continue
      player.push(deck.pop)
      return false if check_busted?(player) 
    end
    break unless continue
  end
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
  loop do
    show_desk_card(player, host)

    say "Host's turn: "
    puts ""
    say "Press [RETURN] to continue..."
    gets

    return unless host_need_draw_card?(deck, player, host)
    host.push(deck.pop)
    break if check_busted?(host) 
  end
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


loop do
  deck = get_deck(8)
  player = []
  host = []

  game_start(deck, player, host)
  player_not_busted = ask_player_hit(deck, player, host)
  ask_host_hit(deck, player, host) if player_not_busted

  result = compare_result(player, host)

  show_desk_card(player, host)
  say "#{result}"
  puts ""
  say "Play again? (y/n)"
  break unless gets.chomp.downcase == 'y'
end