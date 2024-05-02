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

        it "Mate stopped piece capturing" do
            board = Board.new()
            moves = ["e2 e4", "h7 h5", "d2 d3", "f7 f6", "a2 a3", "g7 g5", "d1 h5"]
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
        
        it "Mate stopped by blocking piece" do
            board = Board.new()
            moves = ["e2 e4", "f7 f6", "d1 h5"]
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

    describe "castling" do
        it "White castle king side" do
            board = Board.new()
            moves = ["e2 e4", "e7 e5", "f1 c4", "d7 d6", "g1 f3", "c8 g4", "e1 g1"]
            curr_player = 0
            index = 0
            moves.length.times do
                board.players[curr_player].take_turn(moves[index])
                index += 1
                curr_player = 1 - curr_player
            end

            puts ""
            board.print_board
            expect(board.squares[0][6].type == "king" && board.squares[0][5].type == "rook").to eql true
        end

        it "Black castle queen side" do
            board = Board.new()
            moves = ["a2 a3", "e7 e5", "b2 b3", "d7 d6", "c2 c3", "d8 e7", "d2 d3", "c8 d7", "e2 e3", "b8 c6", "f2 f3", "e8 c8"]
            curr_player = 0
            index = 0
            moves.length.times do
                board.players[curr_player].take_turn(moves[index])
                index += 1
                curr_player = 1 - curr_player
            end

            puts ""
            board.print_board
            expect(board.squares[7][2].type == "king" && board.squares[7][3].type == "rook").to eql true
        end

        it "White castle FAILS because in check" do
            board = Board.new()
            moves = ["e2 e4", "e7 e5", "f1 c4", "d8 g5", "f2 f3", "a7 a6", "g1 h3", "g5 h4", "e1 g1"]
            curr_player = 0
            index = 0
            moves.length.times do
                board.players[curr_player].take_turn(moves[index])
                index += 1
                curr_player = 1 - curr_player
            end

            puts ""
            board.print_board
            expect(board.squares[0][4].type == "king" && board.squares[0][7].type == "rook").to eql true
        end

        it "Black castle FAILS because pass over attacked space" do
            board = Board.new()
            moves = ["e2 e4", "e7 e5", "d1 f3", "f8 a3", "f3 a3", "g8 h6", "f2 f3", "e8 g8"]
            curr_player = 0
            index = 0
            moves.length.times do
                board.players[curr_player].take_turn(moves[index])
                index += 1
                curr_player = 1 - curr_player
            end

            puts ""
            board.print_board
            expect(board.squares[7][4].type == "king" && board.squares[7][7].type == "rook").to eql true
        end

        it "White castle FAILS because ends in check" do
            board = Board.new()
            moves = ["e2 e4", "c7 c6", "f1 c4", "d8 b6", "f2 f3", "h7 h6", "g1 h3", "g7 g6", "e1 g1"]
            curr_player = 0
            index = 0
            moves.length.times do
                board.players[curr_player].take_turn(moves[index])
                index += 1
                curr_player = 1 - curr_player
            end

            puts ""
            board.print_board
            expect(board.squares[7][4].type == "king" && board.squares[7][7].type == "rook").to eql true
        end

        it "White castle FAILS because king has moved" do
            board = Board.new()
            moves = ["e2 e4", "e7 e5", "f1 c4", "a7 a6", "g1 f3", "b7 b6", "e1 e2", "c7 c6", "e2 e1", "d7 d6"]
            curr_player = 0
            index = 0
            moves.length.times do
                board.players[curr_player].take_turn(moves[index])
                index += 1
                curr_player = 1 - curr_player
            end

            puts ""
            board.print_board
            expect(board.squares[0][4].get_moves.include?([0, 6])).to eql false
        end

        it "White castle FAILS because rook has moved" do
            board = Board.new()
            moves = ["e2 e4", "e7 e5", "f1 c4", "a7 a6", "g1 f3", "b7 b6", "h1 g1", "c7 c6", "g1 h1", "d7 d6"]
            curr_player = 0
            index = 0
            moves.length.times do
                board.players[curr_player].take_turn(moves[index])
                index += 1
                curr_player = 1 - curr_player
            end

            puts ""
            board.print_board
            expect(board.squares[0][4].get_moves.include?([0, 6])).to eql false
        end
    end
end
