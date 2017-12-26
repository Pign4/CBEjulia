import Distributions.sample
import Crayons.Crayon
import Base.Iterators: flatten

struct Mode
    isNewGame::Bool
    size::Int8
    n::Int8
    pieces::String
    pcHelps::Int8
end

function gameMode()::Mode
    ng = true # gameType()
    bs = Int8(4) # boardSize()
    hm = howMany()
    pieces = whichOnes(n)
    pcHelps = Int8(3) # who()
    return Mode(ng, bs, hm, pieces, pcHelps)
end

function newGame()::Bool
    types = ["N", "L"]
    while true
        print("New game (N) or load game (L)? ")
        m = uppercase(readline())
        m in types && return m == types[1]
        println("This game mode doesn't exist!")
    end
end

function boardSize()::Int8
    while true
        print("What's the side length of the board you want to play in (4 or 5)? ")
        size = get(tryparse(Int8, readline()), Int8(0))
        4 <= size <= 5 && return size
        println("The side length can only be 4 or 5!")
    end
end

function howMany()::Int8
    while true
        print("How many pieces are we going to play with (min 4, max 8)? ")
        n = get(tryparse(Int8, readline()), Int8(0))
        4 <= n <= 8 && return n
        println("It must be an integer number between 4 and 8!")
    end
end

function whichOnes(n::Int8)::String
    pieces = "JDPTASMH"
    n == 8 && return pieces
    while true
        print("Which pieces are excluded from the game? ")
        exclude = uppercase(readline())
        if length(exclude) > 8 - n
            println("You chose to play with $n pieces, so you have to exclude exactly $(8-n) pieces!")
        else
            if isempty(setdiff(exclude, pieces))
                exclude *= join(setdiff(pieces, exclude))[randperm(8 - n - length(exclude))]
                return join(setdiff(pieces, exclude))
            end
            println("Error! You can't exclude pieces that are not present in 'JDPTASMH'!")
        end
    end
end

function who()::Int8
    player = ["1", "2", "B"]
    while true
        print("Which player should the PC help (1, 2 or B-oth)? ")
        help = uppercase(readline())
        help in player && return findfirst(player, help)
        println("You must input either 1, 2 or B!")
    end
end

function number2color(number::Char)::Crayon
    number == '4' && return Crayon(background = :magenta, foreground = :white)
    number == '3' && return Crayon(background = :white)
    number == '2' && return Crayon(background = :black, foreground = :white)
    number == '1' && return Crayon(background = :red, foreground = :white)
end

function printBoard(s::Int8, board::Array{String,2})
    boardColor = number2color('4')
    boardLine = [boardColor, " " ^ (9 + (7 + 2) * s), Crayon(reset = true)]
    spaces = repeat([" " ^ 7, "  "], outer = s)
    println(boardLine...)
    for row in 1:s
        colors = collect(flatten(zip([number2color(board[row, col][1]) for col in 1:s], fill(boardColor, s))))
        pieces = collect(flatten(zip(["   $(board[row, col][2])   " for col in 1:s], fill("  ", s))))

        println(boardColor, " " ^ 9, flatten(zip(colors, spaces))... , Crayon(reset = true))
        println(boardColor, "    $("12345"[row])    ", flatten(zip(colors, pieces))... , Crayon(reset = true))
        println(boardColor, " " ^ 9, flatten(zip(colors, spaces))... , Crayon(reset = true))

        println(boardLine...)
    end
    println(boardColor, " " ^ 9, join(["   $("abcde"[col])     " for col in 1:s]), Crayon(reset = true))
    println(boardLine...)
end
