=begin

tracked - turn counts

game class




player class

-name
-token
-move history





game.start 

1. game asks for names from both players - x
2. game creates two new player instances - x
3. game creates game instance with player info - x
4. calls game turn - x

game.turn

1. check win - x
2. checks turn count, assigns player.marker depending on if count is divisible by 2 - x
3. calls get player move - x

get_player_move

1. create board - x
2. ask player for move  - x
3. check to see if valid move, assign if so - x

game_finish

1. prints board
2. prints congrats
3. ask if wants to play again






todo:

build win parameters - x
build check_win - x
build game_turn method - x
build get_player_move - in progress
build game_finish -



123
456
789 

memo: 

=end


class Game 
	attr_accessor :board, :player1, :player2
	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2
		@board = [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
		@turn_count = 0

	end

	def create_board
		@board.each_index {|x|
			if x % 3 == 0
				p @board[(x-2)..x] unless x == 0
			end
		}
	end

	def game_turn
		@turn_count += 1
		player = @turn_count % 2 == 1 ? @player1 : @player2
		check_win(@player1, @player1.moves)
		check_win(@player2, @player2.moves)
		get_move(player)
	end

	def self.start
		puts "Welcome to Tic Tac Toe"
		print "Player 1(X) please enter your name: "
		p1 = gets.chomp
		print "Player 2(O) please enter your name: "
		p2 = gets.chomp
		playerone = Player.new(p1, "X")
		playertwo = Player.new(p2, "O")
		# p1 = "wes"
		# p2 = "bria"
		# playerone = Player.new(p1, "X")   #temp perm players added to aid in irb testing
		# playertwo = Player.new(p2, "O")
		@game = Game.new(playerone, playertwo)
		@game.game_turn
	end

	def check_win(player, player_moves)   #refactor
		win = [[1,2,3], [4,5,6], [7,8,9], [1,4,7],[1,5,9], [2,5,8],[3,6,9],[3,5,7]]
		if @turn_count >= 9
			puts "Looks like we have a tie. What a surprise."
			game_finish
		end

		win.each do |x|
			count = 0
			x.each do |x|
				count += 1 if player_moves.include?(x)
				if count == 3
					puts "Congrats #{player.name}, you win!"
					create_board
					game_finish
				end
			end
		end
	end

	def game_finish
		puts "Would you like to play again?"
		ans = gets.chomp.downcase
		if ans == "yes"
			Game.start
		elsif ans == "no"
			puts "Thanks for playing!"
			exit
		else
			puts "I'm not sure what you mean."
			game_finish
		end
	end

			

	def get_move(player)
		create_board
		answered = 0
		until answered == 1
			p "Choose your move, #{player.name}, (#{player.token}): "
			move = gets.chomp.to_i 		
				if move.to_s == @board[move]
					@board[move] = player.token
					answered += 1
					player.moves << move
					game_turn
				else
					puts "that's not a valid move"
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



#helper methods

def start      #for irb testing
	Game.start
end

def reload #reload current script for irb testing
	load 'tic_tac_toe.rb'
end



Game.start




