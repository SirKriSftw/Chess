require "spec_helper"
require_relative "../lib/board"

describe Player do
    describe "checkmate?" do
        it "Scholar's mate" do
            board = Board.new()
            board.players[0].take_turn("e2 e4")
            board.players[1].take_turn("e7 e5")
            board.players[0].take_turn("f1 c4")
            board.players[1].take_turn("b8 c6")
            board.players[0].take_turn("d1 h5")
            board.players[1].take_turn("g8 f6")
            board.players[0].take_turn("h5 f7")
            board.print_board
            expect(board.players[1].checkmate?).to eql true
        end
    end
end
