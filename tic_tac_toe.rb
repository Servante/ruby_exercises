=begin

tracked - turn counts

game class

player.marker - tracks turn




game.start 

1. game asks for names from both players
2. game creates two new player instances
3. game creates game instance with player info
4. calls game turn

game.turn

1. check win
2. checks turn count, assigns player.marker depending on if count is divisible by 2
3. calls get player move

get.player.move

1. create board
2. ask player for move 
3. check to see if valid move, assign if so

=end


class game 
	attr_accessor:
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
		








