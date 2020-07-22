require 'yaml'

class Game
	attr_accessor :player_name, :remaining_attempts, :key, :missed_letters, :board, :guess_history
	def initialize(player_name, secret_word, encrypted_word)
		@player_name = player_name
		@remaining_attempts = 7
		@key = secret_word
		@missed_letters = []
		@board = encrypted_word
		@guess_history = []
	end

	def self.start
		puts "Welcome to Terminal Hangman"
		puts "\nWhat would you like to do?"
		puts "1 - Start New Game"
		puts "2 - Load Game"
		resp = gets.chomp.to_i

		if resp == 1
			puts "\nWhat's your name?"
			name = gets.chomp
			Game.new_game(name)
		elsif resp == 2
			Game.load_game
		else
			puts "I'm sorry, I don't understand."
			Game.start
		end
	end

	def self.new_game(player_name)	
		secret_word = Game.random_word
		encrypted_word = Game.encrypt(secret_word)
		@game = Game.new(player_name, secret_word, encrypted_word)
		@game.game_turn
	end

	def save_game
		yaml = YAML::dump(self)
		File.open("save_file.yaml", "w+") {|x| x.write yaml}
		puts "\n\nGame saved!"
	end

	def self.load_game
		save_file = File.open("save_file.yaml")
		@game = YAML::load(save_file)
		puts "\nWelcome back #{@player_name}!"
		@game.game_turn
	end

	def self.random_word
	  chosen_word = nil
	  File.foreach("dictionary.txt").each_with_index do |line, number|
	    chosen_word = line if rand < 1.0/(number+1) && line.length > 4 && line.length < 8 && line.scan(/[A-Z]/).empty?
	  end
	  if chosen_word == nil
	  	Game.random_word
	  else 
	  	return chosen_word
		end
	end

	def self.encrypt(word)
		word.gsub(/./, '_')
	end

	def show_board
		puts "\n\n\n"
		mr_doomed = [" " + "|" + " " + "\n", "\\", "o", "/" + "\n", " " + "|" + " " + "\n", "/" + " ", "\\" + "\n"]
		if @missed_letters.size > -1 then print mr_doomed[0...(@missed_letters.size)].join('') end
		puts "\n\n"
		puts @board
		puts "Missed letters: #{@missed_letters}"
		puts "Guesses Remaining: #{@remaining_attempts}"
		puts "\n"
	end

	def edit_board(player_guess)
		@key.split('').each_with_index {|v, i| @board[i] = player_guess if v == player_guess}
	end

	def game_turn
		show_board
		if @remaining_attempts == 0
			puts "I'm sorry, the time has come. The doomed is doomed."
		  puts "The secret word was: #{@key}"
			play_again
		elsif @board.split("").include?("_")
			player_guess
		else
			puts "Congratulations #{player_name}, you've won!"
			play_again
		end
	end

	def player_guess
		puts "Please enter a letter or type 'save' to save and exit.\n"
		i_response = gets.chomp.downcase
		if i_response == "save"
			save_game
			puts "\nWould you like to continue playing?"
			reply = gets.chomp.downcase
			if reply == "yes"
				puts "\nGame on!"
				player_guess
			elsif reply == "no"
				puts "\nSee you next time!"
				exit
			end
		elsif i_response == "key"   #hidden feature reveals secret word
				puts @key
				player_guess
		else
			response = i_response[0]
			if @guess_history.include?(response)
				puts "You've already guessed that letter."
				show_board
				player_guess
			elsif @key.include?(response)
				puts "The secret word contains an #{response}."
				@guess_history << response
				edit_board(response)
				game_turn
			elsif response == nil
				player_guess
			else
				puts "The secret word does not contain an #{response}."
				@guess_history << response
				@remaining_attempts -= 1
				@missed_letters << response
				game_turn
			end
		end
	end

	def play_again		
		show_board
		puts "Would you like to play again?"
		again = gets.chomp.downcase
		if again == "yes" || again == "y"			
			Game.new_game(@player_name)
		else
			puts "Thanks for playing, #{@player_name}!"
			exit
		end
	end
end

Game.start





