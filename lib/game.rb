require_relative "board"

class Game
    def initialize
        @board = Board.new()
        @curr_player_index = 0
        @curr_player = @board.players[@curr_player_index]
    end

    def play
        valid_turn = true
        loop do            
            @curr_player = @board.players[@curr_player_index]
            if valid_turn then @board.print_board end
            if @curr_player.in_check?
                if(@curr_player.checkmate?) 
                    winner = @board.players[1 - @curr_player_index]
                    puts "Checkmate. Player #{winner.color} has won!"
                else
                puts "\e[31mYour king is under attack\e[0m" 
                end
            end
            puts "Player #{@curr_player.color}, what piece would you like to move?\n"
            input = gets.chomp
            valid_turn = @curr_player.take_turn(input)
            if valid_turn  
                @curr_player_index = 1 - @curr_player_index 
            end              
        end
    end
end