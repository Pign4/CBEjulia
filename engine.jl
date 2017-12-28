using ResumableFunctions
import Iterators.product

include("actions.jl")


# must specify the output type. It should be an "Action"
@resumable function allActions(turn::Int8, game::Game)
    if players[turn].canPlace
        for placement in allPlacements(turn, game)
            @yield placement
        end
    end
    # for piece in setdiff(players[turn].placed, players[turn].played)
    #     index = findfirst(board, string(turn) * piece)
    #     for movement in allMovements(turn, piece, index, players, board)
    #         @yield movement
    #     end
    #     for activation in allActivations(turn, piece, index, players, board)
    #         @yield activation
    #     end
    # end
    # not sure what to do with return, maybe it will be more clear after the sub-generators are done
    # return actions
end

@resumable function allPlacements(turn::Int8, game::Game)
    squares = filter(x -> isFreeSquare(x, game.board), game.startSquares)
    for piece, square in product(game.players[turn].hand, squares)
        action = piece * index2coords(square)
        handIndex = findfirst(game.players[turn].hand, piece)
        @yield Placement(turn, piece, square, action, handIndex, [])
    end
end

function isFreeSquare(index::Int8, board::Array{String,1})
    return board[index] == "3 "
end

function index2coords(index::Int8, size::Int8)::String
    return "abcde"[index % size] * string(size - floor(index / size))
end
