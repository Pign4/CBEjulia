include("printfs.jl")
include("player.jl")
include("engine,jl")

function playTurn!(s::Int8, board::Array{String,1})
    printBoard(s, board)
end

function startTurn!(turn::Int8, winner::Int8, bestPlay::String, pcHelps::Int8,
                    board::Array{String,2}, startSquares::Tuple{Array{Int64,1},Array{Int64,1}},
                    players::Array{Array{Any,1},1})::Array{Any,1}
    actions = allActions(turn, board)
    if isempty(actions)
        winner = Int8(3) - turn
    else
        # (pcHelps == 3 || pcHelps == turn) && bestPlay = worstCase()
    end
    return actions
end

function createGame(n, size::Int8, pieces::String)::Game
    board = reshape(fill("3 ", size^2), (size, size))
    startSquares = mode.size == 4 ? ([9,14],[3,8]) : ([11,17,23], [3,9,15])
    players = [Player(collect(pieces[randperm(end)]), [], [], [], true),
               Player(collect(pieces[randperm(end)]), [], [], [], true)]
    winner = zero(Int8)
    return Game(mode.size, board, startSquares, players, winner)
end

mutable struct Game
    size::Int8
    board::Array{String,2}
    startSquares::Tuple{Array{Int64,1},Array{Int64,1}}
    players::Array{Player,1}
    winner::Int8
end

mutable struct Player
    pile::Array{Char,1}
    hand::Array{Char,1}
    placed::Array{Char,1}
    played::Array{Char,1}
    canPlace::Bool
end

function main()::Void
    # get input
    thisMode = gameMode()

    # create game objects
    if thisMode.isNewGame
        thisGame = createGame(thisMode)
        history = [[]]
        back = false
        actions = []
        bestPlay = ""
    else
        println("bruh")
    end

    # initial draws
    startGame!(players)

    # main loop
    turn = one(Int8)
    while winner == 0
        actions = startTurn!(turn, winner, bestPlay, pcHelps, board)
        # println(actions)
        # break
        # while winner == 0 && !isempty(actions)
        #     !playTurn!() && break
        # end
        # endTurn()
        # turn = one(Int8) - turn
    end

    return
end

main()
