# Palindrome
def palindrome?(string)
    reverse = string.reverse.downcase
    return string.downcase == reverse
end

# Count Words
def count_words(string)
    result = Hash.new(0)
    
    text = string.downcase.split(/\s+|\W*\s+|\W\z/)
    text.each { |word| result[word] += 1 }
    
    result = result.sort_by do |word, count|
        count
    end
    
    result.reverse!
    
    string_to_puts = "# => { "
    result.each do |word, count|
        string_to_puts += "\'#{word}\' => \'#{count}\' "
    end
    return string_to_puts + "}"
end

# Rock-Paper-Scissors
# Part 2 (a)

class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end
    
def rps_game_winner(game)
    
    raise WrongNumberOfPlayersError unless game.length == 2

    strategies = ["R","P","S"]

    player_strat = []
        
    game.each do |player|
        player_strat.push(player[1])
    end

    player_strat.each do |strat|
        raise NoSuchStrategyError unless strategies.include? strat
    end
        
    result = once_twice_three_shoot(player_strat)
    if result == 1
        puts "#{game[0]}"
    else
        puts "#{game[1]}"
    end
end

def once_twice_three_shoot(selections)
    case selections
    when ["R","P"]
        # paper covers rock, player 2 wins
        return 2
    when ["R","S"]
        # rock crushes scissors, player 1 wins
        return 1
    when ["P","R"]
        # paper covers rock, player 1 wins
        return 1
    when ["P","S"]
        # scissors cuts paper, player 2 wins
        return 2
    when ["S","R"]
        # rock crushes scissors, player 2 wins
        return 2
    when ["S","P"]
        # scissors cuts paper, player 1 wins
        return 1
    else
        # it's a tie, default to player 1 in this case
        return 1
    end
end

# Part 2(b) (Extra Credit)

def rps_tournament_winner(tournament)
    winner = []
    begin
        winner = rps_game_winner(tournament)
    rescue
        tournament.each do |game|
            rps_tournament_winner(game)
        end
    end
    return winner
end

# Part 3: Anagrams

def combine_anagrams(words)
    grouped_anagrams = Hash.new
    
    words.each do |keys|
        grouped_anagrams[keys.downcase.chars.sort.join] = []
    end
    
    grouped_anagrams.each do |key, list_of_compatible_words|
        words.each do |current_word|
            if current_word.downcase.chars.sort.join == key
                list_of_compatible_words.push(current_word)
            end
        end
    end
    
    return grouped_anagrams
end

# Part 4: OOP

class Dessert
    
    attr_accessor :name, :calories
    
    def initialize(name, calories)
        @name = name
        @calories = calories
    end
  
    def healthy?
        return self.calories < 200
    end
    
    def delicious?
        return true
    end 
end

class JellyBean < Dessert
    
    attr_accessor :name, :calories, :flavor
    
    def initialize(name, calories, flavor)
        super(name, calories)
        @flavor = flavor
    end
  
    def delicious?
        return flavor != "Black Licorice"
    end 
end

# -------------------------
# Testing...

# Test Data:

pal1 = "Go hang a salami, I'm a lasagna hog!"
pal2 = "A man, a plan, a canal -- Panama!"
pal3 = "Abracadabra."

game = [ [ "Armando", "P" ], [ "Dave", "S" ] ]
error_game = [ ["Jesse", "P"], ["Gray Cat", "T"] ]

tournament = [ [ [ ["Armando", "P"], ["Dave", "S"] ], [ ["Richard", "R"],  ["Michael", "S"] ], ], [ [ ["Allen", "S"], ["Omer", "P"] ], [ ["David E.", "R"], ["Richard X.", "P"] ] ] ]

words = ['cars', 'for', 'potatoes', 'racs', 'four','scar', 'creams', 'scream']
more_words = ['Cars', 'for', 'potaTOES', 'racs', 'Scar', 'creams', 'SCREAM']

# Testing palindrome?
puts "Testing palindrome?(string)"
puts "----------"

puts
puts "Input: #{pal1}"
puts "Converting string to list of words..."
clean_pal1 = pal1.gsub(/\W/, "")
puts "Expected output: true"
print "Actual output: "
puts palindrome?(clean_pal1)

puts
puts "Input: #{pal2}"
puts "Converting string to list of words..."
clean_pal2 = pal2.gsub(/\W/, "")
puts "Expected output: true"
print "Actual output: "
puts palindrome?(clean_pal2)

puts
puts "Input: #{pal3}"
puts "Converting string to list of words..."
clean_pal3 = pal3.gsub(/\W/, "")
puts "Expected output: false"
print "Actual output: "
puts palindrome?(clean_pal3)

puts "----------"
puts

# Testing Count Words
puts "Testing count_words(string)"
puts "----------"

puts
puts "Input: #{pal1}"
puts "Expected output: # => { 'a' => '2' 'go' => '1' 'hang' => '1' 'hog' => '1' 'lasagna' => '1' 'i'm' => '1' 'salami' => '1' }"
print "Actual output: "
puts count_words(pal1)
puts "(Out of order is ok. This is a hash.)"

puts
puts "Input: #{pal2}"
puts "Expected output: # => { 'a' => '3' 'canal' => '1' 'panama' => '1' 'plan' => '1' 'man' => '1' }"
print "Actual output: "
puts count_words(pal2)
puts "(Out of order is ok. This is a hash.)"

puts
puts "Input: #{pal3}"
puts "Expected output: # => { 'abracadabra' => '1' }"
print "Actual output: "
puts count_words(pal3)
puts "(Out of order is ok. This is a hash.)"

puts "----------"

puts
# Testing rps_game_winner(game)
puts "Testing rps_game_winner(game)"
puts "----------"

puts "Input: #{game}"
puts "Expected output: [\"Dave\", \"S\"]"
print "Actual output: "
print rps_game_winner(game)
puts "----------"

puts
# Testing rps_tournament_winner(tournament)
puts "Testing rps_tournament_winner(tournament)"
puts "Input: #{tournament}"
puts "Expected output: [\"Richard\", \"R\"]"
print "Actual output: "
puts rps_tournament_winner(tournament)
puts "----------"

puts
# Testing anagrams
puts "Testing anagrams"
puts "----------"

puts "Input: words = ['cars', 'for', 'potatoes', 'racs', 'four','scar', 'creams', 'scream']"
puts "Expected output: [[\"cars\", \"racs\", \"scar\"], [\"four\"], [\"for\"], [\"potatoes\"], [\"creams\", \"scream\"]]"
print "Actual output: "
anagrams = combine_anagrams(words)

print "["
anagrams.each do |key, list_of_compatible_words|
    print "#{list_of_compatible_words}"
end
print "]"
puts

puts
puts "Input: words = ['Cars', 'for', 'potaTOES', 'racs', 'four','Scar', 'creams', 'SCREAM']"
puts "Expected output: [[\"Cars\", \"racs\", \"Scar\"], [\"four\"], [\"for\"], [\"potaTOES\"], [\"creams\", \"SCREAM\"]]"
print "Actual output: "
anagrams = combine_anagrams(more_words)

print "["
anagrams.each do |key, list_of_compatible_words|
    print "#{list_of_compatible_words}"
end
print "]"
puts

puts
# Testing Dessert and JellyBean Class
puts "Dessert and JellyBean Test"
puts "----------"

puts
puts "creating cake object, with 250 calories..."
puts "creating fruit object, with 25 calories..."
puts "creating JellyBean object, with 75 calories and Black Licorice flavor..."
puts "creating JellyBean object, with 125 calories and Watermelon flavor..."
puts

cake = Dessert.new("Cake", 250)
fruit = Dessert.new("Fruit", 25)
bl_Jellybean = JellyBean.new("Black Licorice Jelly Bean", 75, "Black Licorice")
wtm_JellyBean = JellyBean.new("Watermelon Jelly Bean", 125, "Watermelon")

puts "Checking cake..."
puts "cake.delicious?"
puts "Expected output: true"
puts "Actual output: #{cake.delicious?}"
puts

puts "cake.healthy?"
puts "Expected output: false"
puts "Actual output: #{cake.healthy?}"

puts "----------"
puts "Checking jellybeans..."
puts "bl_Jellybean.delicious?"
puts "Expected output: false"
puts "Actual output: #{bl_Jellybean.delicious?}"
puts

puts "bl_Jellybean.healthy?"
puts "Expected output: true"
puts "Actual output: #{bl_Jellybean.healthy?}"
puts

puts "wtm_JellyBean.delicious?"
puts "Expected output: true"
puts "Actual output: #{wtm_JellyBean.delicious?}"
puts

puts "wtm_JellyBean.healthy?"
puts "Expected output: true"
puts "Actual output: #{wtm_JellyBean.healthy?}"
puts 