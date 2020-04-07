=begin

tracked - turn counts

game class




player class

-name
-token
-move history





game.start 

1. game asks for names from both players
2. game creates two new player instances
3. game creates game instance with player info
4. calls game turn

game.turn

1. check win
2. checks turn count, assigns player.marker depending on if count is divisible by 2
3. calls get player move

get.player_move

1. create board
2. ask player for move 
3. check to see if valid move, assign if so






=end


class Game 
	attr_accessor 
	def initialize (player, player_marker)
		@player = player
		@player_marker = player_marker
		@board = [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
	end

	def create_board
		@board.each_index {|x|
			if x % 3 == 0
				p @board[(x-2)..x] unless x == 0
			end
		end
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


	end

end

class Player
	attr_accessor :name, :token
	def initialize (name, token)
		@name = name
		@token = token
	end
end













