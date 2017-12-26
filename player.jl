function startGame!(players::Array{Array{Any,1},1})::Void
    draw!(players[1])
    draw!(players[1])
    draw!(players[2])
    return
end

function draw!(player::Array{Any,1})::Void
    push!(player[2], pop!(player[1]))
    return
end
