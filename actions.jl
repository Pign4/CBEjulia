mutable struct Placement
    player::Int8
    piece::String
    square::Int8
    action::String
    handIndex::Int8
    destroyed::Array{Any,1}
end

function execute(placement::Placement, game::Game)
    
end
