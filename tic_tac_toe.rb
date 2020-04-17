class Game 
	attr_accessor :board, :player1, :player2
	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2
		@board = [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
		@turn_count = 0

	end

	def create_board
		@board.each_index do |x|
			if x % 3 == 0
				p @board[(x-2)..x] unless x == 0
			end
		end
		puts "\n\n\n"
	end

	def game_turn
		@turn_count += 1
		player = @turn_count % 2 == 1 ? @player1 : @player2
		check_win(@player1, @player1.moves)
		check_win(@player2, @player2.moves)
		get_move(player)
	end

	def self.start
		print "Player 1 (X) please enter your name: "
		p1 = gets.chomp
		puts "\n\n\n"
		print "Player 2 (O) please enter your name: "
		p2 = gets.chomp
		puts "\n\n\n"
		playerone = Player.new(p1, "X")
		playertwo = Player.new(p2, "O")
		@game = Game.new(playerone, playertwo)
		@game.game_turn
	end

	def check_win(player, player_moves)   #refactor
		win = [[1,2,3], [4,5,6], [7,8,9], [1,4,7],[1,5,9], [2,5,8],[3,6,9],[3,5,7]]
		if @turn_count >= 9
			puts "Looks like we have a tie. What a surprise."
			puts "\n\n\n"
			game_finish
		end

		win.each do |x|
			count = 0
			x.each do |x|
				count += 1 if player_moves.include?(x)
				if count == 3
					puts "Congrats #{player.name}, you win!"
					puts "\n\n\n"
					create_board
					game_finish
				end
			end
		end
	end

	def game_finish
		puts "Would you like to play again?"
		ans = gets.chomp.downcase
		puts "\n\n\n"
		if ans == "yes"
			Game.start
		elsif ans == "no"
			puts "Thanks for playing!"
			exit
		else
			puts "I'm not sure what you mean."
			puts "\n\n\n"
			game_finish
		end
	end			

	def get_move(player)
		create_board
		answered = 0
		until answered == 1
			print "Choose your square, #{player.name} (#{player.token}): "
			move = gets.chomp.to_i 		
			puts "\n\n\n"
				if move.to_s == @board[move]
					@board[move] = player.token
					answered += 1
					player.moves << move
					game_turn
				else
					puts "that's not a valid move"
					puts "\n\n\n"
				end
		end
	end
end

class Player
	attr_accessor :name, :token, :moves
	def initialize(name, token)
		@name = name
		@token = token
		@moves = []
	end
end



#IRB helper methods

def start      #starts game
	Game.start
end

def reload #reloads script
	load 'tic_tac_toe.rb'
end

puts "Welcome to Tic Tac Toe\n\n\n"

Game.start




