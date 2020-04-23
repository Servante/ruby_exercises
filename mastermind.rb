=begin

1. - Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!- in progress

2 - Now refactor your code to allow the human player to choose whmmether he/she wants to be the creator of the secret code or the guesser.

3. - Build it out so that the computer will guess if you decide to choose your own secret colors. Start by having the computer guess randomly (but keeping the ones that match exactly).

4. - Next, add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, its next guess will need to include that color somewhere. Feel free to make the AI even smarter.


*write a variable that includes instructions for the game (including: color description). advise the player they can scroll up to see the abbreviations

*variable that holds the key combo of colors will be called "shield"

*add feature to choose 8 or 12 turns in game

*when displaying board, be sure to display attempt number and how many remaining

------

*full game

-is either player vs player or player vs computer

-decide on who many rounds in a game. has to be an even number. 

-codemaker earns points. one point for every guess, and one extra point if the other person can't solve it. winner is based on who has the most points. 

-codebreaker and codemaker classes. utilize inheritance with game and player classes


pieces:

decoding board (one board with four holes, smaller board to the side with four small holes)
code pegs - six different colors (red[r], green[g], blue[b], yellow[y], pink[p], orange[o])
key pegs -  black and white (for this game we will use x's and o's)
	-x = for correct color and position
	-o = for correct color, but not the position



game flow:

single player version:

game starts up  -  complete
-shield creation
-asks player for name
-asks player how many guess attempts they want/difficulty (easy: 12, hard: 8)
-creates player
-creates game object with player, shield and difficulty


turn
-displays board
-checks guess limit
-asks player for guess
	-uses serialization technique to repeatedly add inputs into an array until player is done typing
		-checks to make sure there are four guesses, and that they all conform to correct abbreviations
		-game performs check_win
			-checks guess against shield
			-game_win if match, else, runs feedback
			-updates board hash with guess attempt and feedback
-prints hash
-guess limit updated
	if guess_limit > difficulty game_lose
		





game.class methods

game - 

instance variables: player, shield array, attempt_count - x
shield_creation(method) - x
colors(array) - x
turn(method)
game_win(method)
game_lose(method)
check_win(method)
feedback(method)

=end


#IRB helper methods


def reload
	load 'mastermind.rb'
end


game_board = {"attempt 1" => [["r", "b", "g", "b"], ["x", "x", "o"]]}


class Game
	attr_accessor :player, :shield
	def initialize(player, shield, difficulty)
		@player = player
		@shield = shield
		@difficulty = difficulty
		@attempt_count = 0
	end



	def self.start
		shield = shield_creation
		puts "Welcome to Mastermind. Terminal Edition."
		puts "You will be the codebreaker. What is your name?"
		name = gets.chomp
		puts "Choose your difficulty, #{name}. Input 'easy' for 12 guess attempts and 'hard' for 8."
		ans = gets.chomp.downcase
		diff = ans == "easy" ? 8 : 12
		@game = Game.new(name, shield, diff)
	end


	def shield_creation
		color_array = ["r", "y", "b", "p", " ", "g"]
		shield = []
		repeat = 0
		while repeat < 4
			shield << color_array.sample
			repeat += 1
		end
		return shield
	end

	def game_turn
		#guess method - use an enumerator to ask the players guess for each position
	end

end