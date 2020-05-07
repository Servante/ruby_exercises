=begin

Mastermind
version: 00
05/06/2020

=end


#IRB helper methods


def reload
	load 'mastermind.rb'
end


instructions = <<HEREDOC

	Mastermind is a codebreaking game. A pattern of six colors is created, and the 
	player has muliple attempts to guess the pattern. Feedback is given on each 
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
	guesses to make more informed attempts. 

THE DECODING BOARD

	As you play the board will create itself. See below for a sample line from the
	board:


	Attempt 1: [r, y, p, r] Feedback: [-, O, O, X]

	
	The above tells you the attempt number you're on and your guess pattern. From 
	the feedback we can see that we got one completely wrong (-), two colored pegs 
	correct, but not in the right position (O,O), and one was dead on in both color 
	and position (X).

HEREDOC


class Game
	attr_accessor :player, :shield, :board
	def initialize(player, shield, difficulty)
		@player = player
		@shield = shield
		@difficulty = difficulty
		@attempt_count = 1
		@board = {}
		@color = ["r", "g", "b", "y", "p", "o"]
	end


	def self.shield_creation
		color_array = ["r", "y", "b", "p", "g"]
		shield = []
		repeat = 0
		while repeat < 4
			shield << color_array.sample
			repeat += 1
		end
		return shield
	end

	def game_turn
		if @attempt_count > @difficulty
			puts "\nSorry! The code remains uncracked."
			p @shield
			play_again
			exit
		else
			guess
		end
	end

	def guess
		pos_no = 1
		reply_array = []
		puts "\n\nEnter the first letter of chosen color: \nred[r], green[g], blue[b], yellow[y], pink[p], orange[o]"
		until pos_no >= 5
			puts "\nWhat's your guess for position #{pos_no}?"
			reply = gets.chomp[0].downcase
			if @color.include?(reply)
				reply_array << reply
			  pos_no += 1
			elsif reply == "x"
				p @shield
			else
				puts "\nPlease use one of the key colors: r, b, o, y, p, g. Try again."
			end
		end
		@board[@attempt_count] = reply_array
		feedback(@board[@attempt_count])	
		show_board
	end

	def play_again
		puts "Would you like to play again?"
		res = gets.chomp.downcase
		if res == "yes"
			Game.start
		elsif res == "no"
			puts "Thanks for playing!"
			exit
		else
			"I don't understand."
		end
	end

	def self.get_difficulty
		puts "\nChoose your difficulty, #{name}. Input 'easy' for 12 guess attempts and 'hard' for 8."
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

	def show_board
		puts "\n\n"
		@board.each {|k, v|
			puts "Attempt [#{k}: #{@board[k][(0...4)].join(", ")}] Feedback: [#{@board[k][4].join(", ")}]"
		}
		puts "\n\n"
		game_turn
	end

	def self.start
		shield = Game.shield_creation
		puts "You will be the codebreaker. What is your name?"
		name = gets.chomp
		diff = Game.get_difficulty
		@game = Game.new(name, shield, diff)
		@game.game_turn
	end

	def feedback(guess_arr)
		fb_array = []
		if guess_arr == @shield
			puts "\nYou win! The code has been cracked open like an egg."
			play_again
		else
			guess_arr.each_with_index {|v, i|
				if @shield.include?(v) && @shield[i] == v
					fb_array << "X"
				elsif @shield.include?(v) && @shield[i] != v
					fb_array << "O"
				else
					fb_array << "-"
				end
			}			
		end
		@board[@attempt_count] << fb_array.sort
		@attempt_count += 1
	end
end

def intro
	puts "\nType 'view' to read the instructions and 'start' to begin the game."
	reply = gets.chomp.downcase
	case reply
	when "view"
		puts instructions
		Game.Start
	when "start"
		Game.start
	else
		puts "\nI'm sorry, I don't understand."
		intro
	end
end



puts "Welcome to Mastermind. Terminal Edition.\n"

intro




