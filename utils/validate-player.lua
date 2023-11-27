--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.validatePlayer(player)
    if player == nil then
        return false
    end
    if not player.valid then
        return false
    end
    if player.character == nil then
        return false
    end
    if not player.connected then
        return false
    end
    if game.players[player.name] ~= nil then
        return false
    end
    return player.crafting_queue_size > 0
end
return ____exports
