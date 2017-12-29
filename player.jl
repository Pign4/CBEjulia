mutable struct Player
    pile::Array{Char,1}
    hand::Array{Char,1}
    placed::Array{Char,1}
    played::Array{Char,1}
    canPlace::Bool
end

function startGame!(players::Array{Player,1})::Void
    draw!(players[1])
    draw!(players[1])
    draw!(players[2])
    return
end

function draw!(player::Player)::Void
    push!(player.hand, pop!(player.pile))
    return
end

function place!(player::Player, piece::String, index::Int8)
    player.hand.deleteat!(index)
    player.placed.push!(piece)
    player.played.push!(piece)
    player.canPlace = false
end
