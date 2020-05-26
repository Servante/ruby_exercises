=begin

Assignment


1. - Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!- complete

2 - Now refactor your code to allow the human player to choose whether he/she wants to be the creator of the secret code or the guesser.

3. - Build it out so that the computer will guess if you decide to choose your own secret colors. Start by having the computer guess randomly (but keeping the ones that match exactly).

4. - Next, add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, its next guess will need to include that color somewhere. Feel free to make the AI even smarter.


*write a variable that includes instructions for the game (including: color description). advise the player they can scroll up to see the abbreviations

*variable that holds the key combo of colors will be called "shield"

*add feature to choose 8 or 12 turns in game


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
	-X = for correct color and position
	-O = for correct color, but not the position

methods:

Game

intro
new_game
show_board
create_shield
get_difficulty
game_turn
get_player_guess
feedback
play_again


Bot 

bot_guess
consider_feedback



To Do:

-finish rewriting code to include new classes


Create hash that will take two values(arrays) as a value

h = Hash.new{|hsh,key| hsh[key] = [] }
h['k1'].push 'a'
h['k1'].push 'b'



=end


require 'pry'


def reload
	load 'mastermind.rb'
end


instructions = <<HEREDOC

	Mastermind is a codebreaking game. A pattern of four colors is created, and the 
	player has muliple attempts to guess this pattern. Feedback is given on each 
	guess that contains clues to how close the player came to guessing the correct 
	pattern. 


THE CODE PEGS

	There will be six colors to choose from when you guess, but this is a terminal 
	game after all, so the colors will be represented by the first letter of the 
	word of the color. 

	red[r], green[g], blue[b], yellow[y], pink[p], orange[o]

THE KEY PEGS

	The key pegs will give you clues to how close your guess was. X's tell you 
	that you got one code peg the correct color and position; while O reveals 
	that only the color was correct. Review your feed back along with your 
	guesses to make more informed a3ttempts. 

THE DECODING BOARD

	As you play the board will create itself. See below for a sample line from the
	board:


	Attempt 1: [r, y, p, r] Feedback: [-, O, O, X]

	
	The above tells you the attempt number you're on and your guess pattern. From 
	the feedback we can see that we got one completely wrong (-), two colored pegs 
	correct, but not in the right position (O,O), and one was dead on in both color 
	and position (X).

HEREDOC

CODE_PEGS = ["r", "g", "b", "y", "p", "o"].freeze

class Game
	attr_accessor :player, :bot, :shield, :board 
	def initialize(player, bot, shield, difficulty)
		@player = player
		@bot = bot
		@shield = shield
		@difficulty = difficulty
		@attempt_count = 1
		@board = {}
	end

	def self.intro
		puts "\nWelcome to Mastermind. Terminal Edition.\n"
		puts "\nDo you wish to view the instructions?"
		reply = gets.chomp.downcase
		if reply == "yes"
			puts instructions
		elsif reply == "no"
			puts "\n"
		else
			"I do not understand."
			intro
		end
	end

	def self.new_game
		Game.intro
		puts "What's your name?"
		name = gets.chomp
		puts "Would you like to be the codebreaker or codemaker?"
		role = gets.chomp.downcase
		diff = nil
		if role == 'codemaker'
			puts "Well then, let's create your secret code."
			shield = Game.create_shield
			diff = [8, 12].sample
			puts "The ships computer will try and crack your code within #{diff} attempts."		
		elsif role == 'codebreaker'
			shield = Bot.create_shield
			puts "MUTHR has created a code for you. If you can crack it you will surviv9, I mean win."
			puts "\nChoose your difficulty: #{name}."
			diff = Game.get_difficulty
		else
			puts "I am not following."
			new_game
		end
		player = Player.new(name, role)
		bot = Bot.new(role == 'codemaker' ? 'codebreaker' : 'codemaker')
		@game = Game.new(player, bot, shield, diff)
		@game.game_turn
	end

	def show_board
		puts "\n\n"
		@board.each {|k, v|
			puts "Attempt #{k}: [#{@board[k][(0...4)].join(", ")}] Feedback: [#{@board[k][4].join(", ")}]"
		}
		puts "\n\n"
		puts "Press any key to continue: "
		x = gets.chomp    #serves no purpose but to add a breather to bot guessing
		game_turn
	end

	def self.create_shield
		shield = []
		puts "\n Would you like to create the code yourself or randomly?"
		puts "Please type 'm' for manual, or 'r' for random."
		reply = gets.chomp[0].downcase
		reply == nil ? "nil" : reply.downcase!
		if reply == "m"
			pos = 1
			until pos >= 5
				puts "Choose a color(r, b, g, y, p, o) for position #{pos}: "
				resp = gets.chomp[0]
				resp == nil ?  "nil" : resp.downcase! 
				if ["r", "g", "b", "y", "p", "o"].include?(resp)
					shield << resp
					pos += 1
				else
					puts "I don't understand."
				end
			end
		elsif reply == "r"
			shield = ["r", "g", "b", "y", "p", "o"].sample(4)
			puts "Secret Code: #{shield}"
		else
			puts "I don't understand?"
			create_shield
		end
		return shield
	end

	def self.get_difficulty
		puts "\nInput 'easy' for 12 guess attempts and 'hard' for 8."
		ans = gets.chomp.downcase
		if ans == "easy"
			return 12
		elsif ans == "hard"
			return 8
		else
			puts "\nI'm sorry, I don't understand."
			self.get_difficulty
		end
	end

	def game_turn                          
		if @attempt_count > @difficulty
			puts "\nThe code remains uncracked."
			p @shield
			play_again
			exit
		elsif player.role == "codebreaker"
			guess = get_player_guess
			@board[@attempt_count] = guess
			feedback(guess)
			show_board
		else
			feedback(bot.bot_guess)
			show_board

		end
	end

	def get_player_guess
		pos_no = 1
		reply_array = []
		puts "\nAnd another one...\n" if @attempt_count > 1
		puts "\n\nEnter the first letter of chosen color: \nred[r], green[g], blue[b], yellow[y], pink[p], orange[o]"
		until pos_no >= 5
			puts "\nWhat's your guess for position #{pos_no}?"
			reply = gets.chomp[0]
			reply == nil ?  "nil" : reply.downcase! 
			if CODE_PEGS.include?(reply)
				reply_array << reply
			  pos_no += 1
			elsif reply == "x"
				p @shield
			else
				puts "\nPlease use one of the key colors: r, b, o, y, p, g. Try again."
			end
		end
		puts "You guessed: #{reply_array.join(", ")}"
		reply_array
	end

	def feedback(reply_array) #from game_turn
		binding.pry
		fb_array = []
		if reply_array == @shield
			puts "\nYou win! The code has been cracked open like an egg."
			play_again
		else	
			reply_array.each_with_index {|v, i|
				if @shield.include?(v) && @shield[i] == v     
					fb_array << "X"
				elsif @shield.include?(v) && @shield[i] != v
					fb_array << "O"
				else
					fb_array << "-"
				end
			}			
		end
		binding.pry
		@board[@attempt_count] = reply_array
		@board[@attempt_count] << fb_array
		binding.pry
		bot.bot_review(reply_array)
		@attempt_count += 1
	end

	def play_again
		puts "Would you like to play again?"
		res = gets.chomp.downcase
		if res == "yes"
			Game.new_game
		elsif res == "no"
			puts "Thanks for playing!"
			exit
		else
			"I don't understand."
		end
	end
end

class Player
	attr_accessor :name, :role
	def initialize(name, role)
		@name = name
		@role = role
	end

end

class Bot
	attr_accessor :name, :role, :memory, :knowledge
	def initialize(role)
		@name = "MUTHR"
		@role = role
		@memory = ["r", "g", "b", "y", "p", "o"]
		@knowledge = {"-" => Hash.new{|hsh, key| hsh[key] = []}}
	end

	def self.create_shield
		CODE_PEGS.sample(4)
	end

	def bot_guess
		pos_no = 1
		reply_array = []
		binding.pry
		puts "The ship shudders as MUTHR reallocates processing power to your code."
		until pos_no >= 5
			if @knowledge.has_key?(pos_no - 1)
				reply_array << @knowledge[pos_no - 1]
				pos_no += 1					
			else 
				reply_array << memory.sample
				pos_no += 1
			end
		end		
		puts "MUTHR's guess: #{reply_array.join(", ")}"
		return reply_array
		binding.pry
	end

	def bot_review(reply_feedback)          #clean up method
		binding.pry
		reply_feedback.each do |feedback|
			feedback.each_with_index do |v, i|
				binding.pry
				if v == "X"
					@knowledge[i] = v
				elsif v == "O"
					@memory << v 	#adds value to memory bank - needs to be reworked, ineffective
				elsif v == "-"
					@knowledge["-"][i].push v
				else
					puts "test"
				end
			end
		end
	end
end


#knowledge["-"][1].empty?



Game.new_game







=begin
	
bot_review:


bot will take in feedback array and check if there are any x's
	-if yes - bot will add color and index to knowledge hash
and then it will check if there are any O's
	-if yes - bot will add O creating colors to memory array

bot_guess:

if position_count equals a knowledge hash key, return the hash value
otherwise do random sample of memory array




=end
