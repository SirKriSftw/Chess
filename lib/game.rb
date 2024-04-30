require_relative "board"

class Game
    def initialize
        @board = Board.new()
        @curr_player_index = 0
        @curr_player = @board.players[@curr_player_index]
    end

    def play
        loop do
            @curr_player = @board.players[@curr_player_index]
            @board.print_board
            puts "Player #{@curr_player.color}, what piece would you like to move?\n"
            input = gets.chomp
            @curr_player.take_turn(input)    
            @curr_player_index = 1 - @curr_player_index
        end
    end
end