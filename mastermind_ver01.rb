=begin

Assignment


1. - Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!- complete

2 - Now refactor your code to allow the human player to choose whether he/she wants to be the creator of the secret code or the guesser.

3. - Build it out so that the computer will guess if you decide to choose your own secret colors. Start by having the computer guess randomly (but keeping the ones that match exactly).

4. - Next, add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, its next guess will need to include that color somewhere. Feel free to make the AI even smarter.

------

*full game

-is either player vs player or player vs computer

-decide on who many rounds in a game. has to be an even number. 

-codemaker earns points. one point for every guess, and one extra point if the other person can't solve it. winner is based on who has the most points. 

pieces:

decoding board (one board with four holes, smaller board to the side with four small holes)
code pegs - six different colors (red[r], green[g], blue[b], yellow[y], pink[p], orange[o])
key pegs -  black and white (for this game we will use x's and o's)
	-X = for correct color and position
	-O = for correct color, but not the position


To Do:

-rewrite instructions - X
-rework instructions in code telling user to type 'help' to view them.
-if easy, rewrite code so that when the user responds yes to play again, it goes straight to choose role  - X
-update the game_win methods to reflect user name or Hal
-clean up alien references (save this to expand on the game in the future, where you track points/rounds)
-update to introduce Hal. note which difficulty he chooses. 
-create an array of famous computer names, and randomly name the bot
-play through and add newlines
-remove all evidence of pry



error: 

he's still picking one's he shouldn't. use binding to go in and find the problem. 

example: 


Attempt 1: [g, r, o, o] Feedback: [O, -, -, -]
Attempt 2: [b, r, p, p] Feedback: [O, -, X, O]
Attempt 3: [g, p, p, o] Feedback: [O, O, X, -]
Attempt 4: [p, o, p, o] Feedback: [O, -, X, -]
Attempt 5: [b, g, p, o] Feedback: [O, X, X, -]
Attempt 6: [b, g, p, b] Feedback: [O, X, X, X]
Attempt 7: [p, g, p, b] Feedback: [O, X, X, X]
Attempt 8: [p, g, p, b] Feedback: [O, X, X, X] - it may also just be chance and not worth fixing. run a few times and compare the results.


bot_review is placing into memory the twin of X producing duplicate values, leading to memory items that are never deleted. 






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

	You choose to be either the codemaker or codebreaker. If you prefer to create
	an unbreakable code, a computer oppenent will be chosen to try and crack it. If
	you decide you want to test your own logical prowess, a computer oppenent will 
	create a pattern more secure than Fort Knox for you to bang your head against. 


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
		puts "\nWhat's your name?"
		reply = gets.chomp.downcase
	end

	def self.new_game(player_name)
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

	def feedback(reply_array) 
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
		@board[@attempt_count] = reply_array
		@board[@attempt_count] << fb_array
		bot.bot_review(reply_array)
		@attempt_count += 1
	end

	def play_again
		puts "Would you like to play again?"
		res = gets.chomp.downcase
		if res == "yes"
			Game.new_game(@name)
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
		@memory = []
		@knowledge = {"-" => Hash.new{|hsh, key| hsh[key] = []}}
	end

	def self.create_shield
		CODE_PEGS.sample(4)
	end


	#1.if knowledge has key reply with hash value
#2.if memory array empty reply with random color code
#3.if memory array has only one item, and that one item hasn't been guessed reply with memory_array
#4.else reply with memory_array

	def bot_guess
		pos_no = 1
		reply_array = []
		one_in_array_guessed = false
		puts "The ship shudders as MUTHR reallocates processing power to your code."
		temp_memory = @memory
		until pos_no >= 5
			if @knowledge.has_key?(pos_no - 1)
				reply_array << @knowledge[pos_no - 1]
				@memory.delete(@knowledge[pos_no - 1]) if @memory.include?(pos_no - 1)
				pos_no += 1					
			elsif temp_memory.empty? || one_in_array_guessed == true
				guess = bot_random_guess
				reply_array << guess
				pos_no += 1
			else
				temp_response = temp_memory.sample
				reply_array << temp_response
				temp_memory.delete(temp_response)
				temp_response = nil
				one_in_array_guessed = true if temp_memory.length < 2
				pos_no += 1
			end
		end		
		puts "MUTHR's guess: #{reply_array.join(", ")}"
		return reply_array
	end

	def	bot_random_guess
		guess = CODE_PEGS.sample
		if @knowledge["-"].values.include?(guess)
			bot_guess_check
		else
			return guess
		end
	end

	def bot_review(reply_feedback)
		added_values = []   
		reply_feedback[4].each_with_index do |v, i|
			if v == "X"     #
				@knowledge[i] = reply_feedback[i]
				@memory.delete(reply_feedback[i]) if @memory.include?(reply_feedback[i])
				added_values << reply_feedback[i]
			elsif v == "O" && @memory.include?(reply_feedback[i]) == false && added_values.include?(reply_feedback[i]) == false
				@memory << reply_feedback[i]
			elsif v == "-"
				@knowledge["-"][i].push reply_feedback[i]
			else
			end			
		end
	end
end


player_name = Game.intro


Game.new_game(player_name)