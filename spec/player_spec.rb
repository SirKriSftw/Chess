require "spec_helper"
require_relative "../lib/board"

describe Player do
    describe "checkmate?" do
        it "Scholar's mate" do
            board = Board.new()
            moves = ["e2 e4", "e7 e5", "f1 c4", "b8 c6", "d1 h5", "g8 f6", "h5 f7"]
            curr_player = 0
            index = 0
            7.times do
                board.players[curr_player].take_turn(moves[index])
                index += 1
                curr_player = 1 - curr_player
            end
            board.print_board
            expect(board.players[1].checkmate?).to eql true
        end
    end
end
