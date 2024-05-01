require "spec_helper"
require_relative "../lib/board"

describe Player do
    describe "checkmate?" do
        it "Scholar's mate" do
            board = Board.new()
            moves = ["e2 e4", "e7 e5", "f1 c4", "b8 c6", "d1 h5", "g8 f6", "h5 f7"]
            curr_player = 0
            index = 0
            moves.length.times do
                board.players[curr_player].take_turn(moves[index])
                index += 1
                curr_player = 1 - curr_player
            end

            board.print_board
            expect(board.players[1].checkmate?).to eql true
        end

        it "Mate stopped by king moving" do
            board = Board.new()
            moves = ["e2 e4", "f7 f6", "d2 d3", "d7 d6", "d1 g4", "g7 g5", "g4 h5"]
            curr_player = 0
            index = 0
            moves.length.times do
                board.players[curr_player].take_turn(moves[index])
                index += 1
                curr_player = 1 - curr_player
            end

            puts ""
            board.print_board
            expect(board.players[curr_player].checkmate?).to eql false            
        end

        
    end
end
