=begin

1. Download the 5desk.txt dictionary file from http://scrapmaker.com/.   -x 

2. When a new game is started, your script should load in the dictionary and randomly select a word between 5 and 12 characters long for the secret word. 

3. You don’t need to draw an actual stick figure (though you can if you want to!), but do display some sort of count so the player knows how many more incorrect guesses he/she has before the game ends. You should also display which correct letters have already been chosen (and their position in the word, e.g. _ r o g r a _ _ i n g) and which incorrect letters have already been chosen.

4. Every turn, allow the player to make a guess of a letter. It should be case insensitive. Update the display to reflect whether the letter was correct or incorrect. If out of guesses, the player should lose.

5. Now implement the functionality where, at the start of any turn, instead of making a guess the player should also have the option to save the game. Remember what you learned about serializing objects… you can serialize your game class too!

6. When the program first loads, add in an option that allows you to open one of your saved games, which should jump you exactly back to where you were when you saved. Play on!


pseudocode

-asks user if they want to load game or start new game 
-randomly puts a word from the dictionary file
	-if word.length > 4 && word.length < 13
		encrypt
	-else
		select another word
-creates a board
	-secret word
	-guess attempts/guess attempts remaining  example: 2/6
	-missed letters
-turn
	-if turn count is >= 6
		puts game over lose message
		display board
	-elsif secret word.!include? "_"
		puts game over win message
		-starts player turn 
	  -displays board
-player turn 
	-asks player for guess
		-guess_count += 1
		-checks to see if secret word includes guess
			-if so, updates board
					-word uncovered
					-remove letter from correct_letter
			-if not
					-guess counts updated
					-missed letter added to missed array




methods:


start
new_game
encrypt
show_board
game_turn
random_word
edit_board
game_over
player_guess


GITHUB:

debug, looped player_guess for nil, backdoor key reveal, game_over method added, program stable/playable



to-do:

finish changing guess attempts to guesses remaining - x
build in secret word reveal - x 
build game_over method - x 
test code - x
begin serialization
	load functionality
	save functionality
write instructions
utilize player name
cosmetic runthrough
	-add newlines
	-add asterisks around board



bugs:

missed letters isn't working - x





=end





require 'pry'

class Game
	attr_accessor :player_name, :attempt_count, :remaining_attempts, :missed_letters, :board, :guess_history
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
		puts "What would you like to do?"
		puts "1 - New Game"
		puts "2 - Load Game"
		puts "3 - Help"
		resp = gets.chomp.to_i

		case resp
		when 1
			puts "What's your name?"
			name = gets.chomp
			Game.new_game(name)
		when 2
			#load game
		when 3
			#instructions
		end
	end

	def self.new_game(player_name)	
		secret_word = Game.random_word
		encrypted_word = Game.encrypt(secret_word)
		@game = Game.new(player_name, secret_word, encrypted_word)
		@game.game_turn
	end

	def self.random_word
	  chosen_word = nil
	  File.foreach("dictionary.txt").each_with_index do |line, number|
	    chosen_word = line if rand < 1.0/(number+1) && line.length > 4 && line.length < 8
	  end
	  return chosen_word
	end

	def self.encrypt(word)
		word.gsub(/./, '_')
	end

	def show_board
		puts @board
		puts "Missed letters: #{@missed_letters}"
		puts "Guesses Remaining: #{@remaining_attempts}"
	end

	def edit_board(player_guess)
		@key.split('').each_with_index {|v, i| @board[i] = player_guess if v == player_guess}
	end

	def game_turn
		show_board
		if @remaining_attempts == 0
			game_over
		else
			player_guess
		end
	end

	def player_guess
		puts "Please enter a letter or type 'save' to save your game."
		response = gets.chomp.downcase
		if response == "save"
			#save the game - ask if they want to keep playing
		else
			#binding.pry
			if @guess_history.include?(response)
				puts "You've already guessed that letter."
				show_board
				player_guess
			elsif @key.include?(response)
				puts "The secret word contains an #{response}."
				@guess_history << response
				edit_board(response)
				game_turn
			elsif response == "key"
				puts @key
				player_guess
			elsif response == nil
				player_guess
			else
				puts "The secret word does not contain an #{response}."
				@guess_history << response
				@remaining_attempts -= 1
				@missed_letters << response
				# binding.pry
				game_turn
			end
		end
	end

	def game_over
		puts "I'm sorry, the time has come. The doomed is doomed."
		puts @key
		show_board
		puts "Would you like to play again?"
		again = gets.chomp.downcase
		# binding.pry
		if again == "yes" || again == "y"			
			Game.new_game(@player_name)
		else
			puts "Thanks for playing, #{@player_name}!"
			exit
		end
	end

end


Game.start








