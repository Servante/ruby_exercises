=begin

1. Download the 5desk.txt dictionary file from http://scrapmaker.com/.   -x 

2. When a new game is started, your script should load in the dictionary and randomly select a word between 5 and 12 characters long for the secret word. 

3. You don’t need to draw an actual stick figure (though you can if you want to!), but do display some sort of count so the player knows how many more incorrect guesses he/she has before the game ends. You should also display which correct letters have already been chosen (and their position in the word, e.g. _ r o g r a _ _ i n g) and which incorrect letters have already been chosen.

4. Every turn, allow the player to make a guess of a letter. It should be case insensitive. Update the display to reflect whether the letter was correct or incorrect. If out of guesses, the player should lose.

5. Now implement the functionality where, at the start of any turn, instead of making a guess the player should also have the option to save the game. Remember what you learned about serializing objects… you can serialize your game class too!

6. When the program first loads, add in an option that allows you to open one of your saved games, which should jump you exactly back to where you were when you saved. Play on!


board - 
	-current word
	-letters missed
	-attempts left (6)

	

write out pseudocode

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
		-turn count += 1
		-checks to see if secret word includes guess
			-if so, updates board
					-word uncovered
					-guess counts updated
					-any missed guesses added to missed array
			-if not
					-guess counts updated
					-missed letter added to missed array


methods:


start
new_game
encrypt
game_turn
random_word
game_over


=end


require 'pry'

class Game
	attr_accessor :player, :attempt_count, :guess_count, :missed_words, :board
	def initialize(player, secret_word, encrypted_word)
		@player = player
		@guess_count = 0
		@secret_word = secret_word
		@missed_words = []
		@board = encrypted_word
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
	    chosen_word = line if rand < 1.0/(number+1) && line.length > 4 && line.length < 13
	  end
	  return chosen_word
	end

	def self.encrypt(word)
		word.gsub(/./, '_')
	end

	def show_board
		puts @board
		puts "Missed letters: #{@missed_words}"
		puts "Guess Attempts: #{@guess_count}/6"
	end

	def game_turn
		if @guesses_remaining = 0
			puts "I'm sorry, the time has come. The doomed is doomed."
			game_over
		else
end


Game.start








