using ResumableFunctions

# must specify the output type. It should be an "Action"
@resumable function allActions(turn::Int8, players::Array{Array{Any,1},1}, board::Array{String,2})
    if players[turn].canPlace
        for placement in allPlacements(turn, players, board)
            @yield placement
        end
    end
    for piece in setdiff(players[turn].placed, players[turn].played)
        index = findfirst(board, string(turn) * piece)
        for movement in allMovements(turn, piece, index, players, board)
            @yield movement
        end
        for activation in allActivations(turn, piece, index, players, board)
            @yield activation
        end
    end
    # not sure what to do with return, maybe it will be more clear after the sub-generators are done
    # return actions
end
