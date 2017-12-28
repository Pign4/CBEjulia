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
