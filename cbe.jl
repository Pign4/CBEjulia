mutable struct Player
    pile::Array{Char,1}
    hand::Array{Char,1}
    placed::Array{Char,1}
    played::Array{Char,1}
    canPlace::Bool
end

include("printfs.jl")
include("player.jl")
# include("engine.jl")

mutable struct Game
    size::Int8
    board::Array{String,2}
    startSquares::Tuple{Array{Int64,1},Array{Int64,1}}
    players::Array{Player,1}
    winner::Int8
end

function playTurn!(s::Int8, board::Array{String,1})
    printBoard(s, board)
end

function startTurn!(turn::Int8, bestPlay::String pcHelps::Int8, game::Game)::Array{Any,1}
    actions = allActions(turn, game)
    if isempty(actions)
        game.winner = Int8(3) - turn
    else
        # (pcHelps == 3 || pcHelps == turn) && bestPlay = worstCase()
    end
    return actions
end

function createGame(size::Int8, pieces::String)::Game
    board = fill("3 ", (Int64(size),Int64(size)))
    startSquares = size == 4 ? ([9,14],[3,8]) : ([11,17,23], [3,9,15])
    players = [Player(collect(pieces[randperm(end)]), [], [], [], true),
               Player(collect(pieces[randperm(end)]), [], [], [], true)]
    winner = zero(Int8)
    return Game(size, board, startSquares, players, winner)
end

function main()::Void
    # get input
    thisMode = gameMode()

    # create game objects
    if thisMode.isNewGame
        thisGame = createGame(thisMode.size, thisMode.pieces)
        history = [[]]
        back = false
        actions = []
        bestPlay = ""
    else
        println("bruh")
    end

    # initial draws
    startGame!(thisGame.players)

    # main loop
    turn = one(Int8)
    while winner == 0
        actions = startTurn!(turn, bestPlay, thisMode.pcHelps, thisGame)
        # println(actions)
        # break
        # while winner == 0 && !isempty(actions)
        #     !playTurn!() && break
        # end
        # endTurn()
        # turn = Int8(3) - turn
    end

    return
end

main()
