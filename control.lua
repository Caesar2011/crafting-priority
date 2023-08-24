---@param player LuaPlayer
local function validatePlayer(player)
    if not player then
        return false
    end
    if not player.valid then
        return false
    end
    if not player.character then
        return false
    end
    if not player.connected then
        return false
    end
    if not game.players[player.name] then
        return false
    end
    if not player.crafting_queue_size then
        return false
    end
    return player.crafting_queue_size > 0
end

---@param player LuaPlayer
local function cancelCraftingQueue(player)
    ---@type CraftingQueueItem[]
    local crafts = {}
    local index = 0
    while player.crafting_queue_size > 0 do
        index = index + 1
        local last_craft = player.crafting_queue[player.crafting_queue_size]
        crafts[index] = last_craft
        player.cancel_crafting{index=last_craft.index, count=last_craft.count}
    end
    return crafts
end

---@param player LuaPlayer
---@param craft CraftingQueueItem
local function beginCrafting(player, craft)
    player.begin_crafting{count=craft.count, recipe=craft.recipe, silent=false}
end

---@param event CustomInputEvent
function promoteCraft(event)
    local player = game.players[event.player_index]
    if not validatePlayer(player) then
        return nil
    end

    local crafts = cancelCraftingQueue(player)
    local length = #crafts

    beginCrafting(player, crafts[1])
    for i = length, 2, -1 do
        beginCrafting(player, crafts[i])
    end
end
script.on_event("promote-craft", --[[---@type]] promoteCraft)


---@param event CustomInputEvent
local function demoteCraft(event)
    local player = game.players[event.player_index]
    if not validatePlayer(player) then
        return nil
    end

    local crafts = cancelCraftingQueue(player)
    local length = #crafts

    for i = length-1, 1, -1 do
        beginCrafting(player, crafts[i])
    end
    beginCrafting(player, crafts[length])

end
script.on_event("demote-craft", --[[---@type]] demoteCraft)


---@param event CustomInputEvent
local function resetCraft(event)
    local player = game.players[event.player_index]
    if not validatePlayer(player) then
        return nil
    end

    local crafts = cancelCraftingQueue(player)
    local length = #crafts

    for i = length, 1, -1 do
        beginCrafting(player, crafts[i])
    end

end
script.on_event("reset-craft", --[[---@type]] resetCraft)

