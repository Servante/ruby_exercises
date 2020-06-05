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
	attr_accessor :player, :bot, :shield, :board, :attempt_count
	def initialize(player, bot, shield, difficulty)
		@player = player
		@bot = bot
		@shield = shield
		@difficulty = difficulty
		@attempt_count = 1
		@board = {}
	end

	def self.new_game(player_name)
		puts "\nWould you like to be the codebreaker or codemaker?\n"
		role = gets.chomp.downcase
		diff = nil
		bot_name = ["MU-TH-R 182","Hal 9000", "V'ger", "Data", "Skynet", "Max Headroom", "J.A.R.V.I.S."].sample
		if role == 'codemaker'
			puts "\nWell then, let's create your secret code.\n"
			shield = Game.create_shield
			diff = [8, 12].sample
			puts "\nYour opponent will be #{bot_name}. It has selected a difficulty of #{diff == 8 ? 'hard' : 'easy'} and will try to break your code within #{diff} attempts.\n"		
		elsif role == 'codebreaker'
			shield = Bot.create_shield
			puts "\n#{bot_name} has created a code for you. If you can crack it you will surviv9, I mean win.\n"
			puts "\nChoose your difficulty:"
			diff = Game.get_difficulty
		else
			puts "\nI am not following.\n"
			new_game
		end
		player = Player.new(name, role)
		bot = Bot.new(bot_name, role == 'codemaker' ? 'codebreaker' : 'codemaker')
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
		puts "\nWould you like to create the code yourself or randomly?"
		puts "\nPlease type 'm' for manual, or 'r' for random."
		reply = gets.chomp[0].downcase
		reply == nil ? "nil" : reply.downcase!
		if reply == "m"
			pos = 1
			until pos >= 5
				puts "\nChoose a color(r, b, g, y, p, o) for position #{pos}: "
				resp = gets.chomp[0]
				resp == nil ?  "nil" : resp.downcase! 
				if ["r", "g", "b", "y", "p", "o"].include?(resp)
					shield << resp
					pos += 1
				else
					puts "\nI don't understand."
				end
			end
		elsif reply == "r"
			shield = ["r", "g", "b", "y", "p", "o"].sample(4)
			puts "\nYour Secret Code: #{shield}"
		else
			puts "\nI don't understand?"
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
			if player.role == "codemaker"
				puts "#{bot.name} has failed to crack your code."
			else
				puts "You have failed to crack #{bot.name}'s code."
			end
			p @shield
			play_again
			exit
		elsif player.role == "codebreaker"
			guess = get_player_guess
			@board[@attempt_count] = guess
			feedback(guess)
			show_board
		else
			feedback(bot.bot_guess(@attempt_count, @board))
			show_board
		end
	end

	def get_player_guess
		pos_no = 1
		reply_array = []
		puts "\nFor guess attempt number #{@attempt_count} - "
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
			if player.role == "codebreaker"
				puts "\nYou win! The code has been cracked open like an egg."
			else
				puts "\n#{bot.name} has cracked your pathetic code."
			end
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
		puts "\nWould you like to play again?"
		res = gets.chomp.downcase
		if res == "yes"
			Game.new_game(@name)
		elsif res == "no"
			puts "\nThanks for playing!"
			exit
		else
			"\nI don't understand."
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
	def initialize(name, role)
		@name = name
		@role = role
		@memory = []
		@knowledge = {"-" => Hash.new{|hsh, key| hsh[key] = []}}
	end

	def self.create_shield
		CODE_PEGS.sample(4)
	end

	def bot_guess(count, board)
		pos_no = 1
		reply_array = []
		one_in_array_guessed = false
		puts "\nThe ship shudders as #{@name} reallocates processing power to your code."
		temp_memory = @memory
		until pos_no >= 5
			if @knowledge.has_key?(pos_no - 1)
				reply_array << @knowledge[pos_no - 1]
				@memory.delete(@knowledge[pos_no - 1]) if @memory.include?(pos_no - 1)
				pos_no += 1					
			elsif temp_memory.empty? || one_in_array_guessed == true || (temp_memory.length < 2 && board[count - 1][pos_no - 1] == temp_memory[0]) 
				guess = bot_random_guess
				reply_array << guess
				pos_no += 1
			else
				temp_response = temp_memory.sample
				reply_array << temp_response
				one_in_array_guessed = true if temp_memory.length < 2 
				temp_memory.delete(temp_response)
				temp_response = nil
				pos_no += 1
			end
		end		
		puts "#{@name}'s guess: #{reply_array.join(", ")}"
		return reply_array
	end

	def	bot_random_guess
		guess = CODE_PEGS.sample
		if @knowledge["-"].values.include?(guess)
			bot_random_guess
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

puts "\nWelcome to Mastermind. Terminal Edition.\n"
puts "\nWould you like to view the instructions?"
resp = gets.chomp.downcase
puts instructions if resp == "yes"
puts "\nLet's get started.\n"
puts "\nPlease enter your name:"
reply = gets.chomp
player_name = reply
Game.new_game(player_name)