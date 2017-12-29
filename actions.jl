mutable struct Placement
    player::Int8
    piece::String
    square::Int8
    action::String
    handIndex::Int8
    destroyed::Array{Any,1}
end

function execute!(game::Game, placement::Placement)
    place!(game.players[placement.player], placement.piece, placement.handIndex)
    game.board[placement.square] = placement.piece
    for adjIndex in getAdjacents(game.size, placement.square) # function in engine still to code
        piece = game.board(adjIndex)
        if piece[1] == string(3 - placement.player)
            if isSurrounded(adjIndex, placement.player, game.board) # function in engine still to code
                placement.destroyed.push!((piece, adjIndex))
            end
        end
    end
end

def goBack(self, board):
    # undo placement
    board.players[self.pl].hand.insert(self.handIndex, self.piece)
    board.players[self.pl].placed.remove(self.piece)
    board.players[self.pl].played.remove(self.piece)
    board.players[self.pl].canPlace = True
    board.pos[self.square] = (2,' ')
    # undo piece destructions
    for (piece, index) in self.destroyed:
        # should I care about piece position inside .placed?
        board.players[1 - self.pl].placed.append(piece)
        board.pos[index] = (1 - self.pl, piece)
