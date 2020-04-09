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

1. check win - in progress
2. checks turn count, assigns player.marker depending on if count is divisible by 2
3. calls get player move

get_player_move

1. create board
2. ask player for move 
3. check to see if valid move, assign if so

game_win

1. prints board
2. prints congrats





todo:

build win parameters - x
build check_win - in progress
build game_turn method
build get_player_move

123
456
789



=end


class Game 
	attr_accessor :board
	win = [[1,2,3], [4,5,6], [7,8,9], [1,4,7],[1,5,9], [2,5,8],[3,6,9],[3,5,7]]
	def initialize(player, player_marker)
		@player = player
		@player_marker = player_marker
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

	def check_win(player)
		count = 0
		win.each {|x|
			x.each {|x|
				if player.moves_history.include?(x)
					count += 1
					if count >= 3
						game.win

			}
		}


	end

	def game_start
		puts "Welcome to Tic Tac Toe"
		print "Player 1(X) please enter your name: "
		p1 = gets.chomp
		print "Player 2(O) please enter your name: "
		p2 = gets.chomp
		playerone = Player.new(p1, "X")
		playertwo = Player.new(p2, "O")
		game = Game.new(playerone, playertwo)
		game_turn

	end

	def game_turn

	end


end





class Player
	attr_accessor :name, :token
	def initialize(name, token)
		@name = name
		@token = token
		@move_history = move_history
	end
end













