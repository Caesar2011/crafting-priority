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
---@param iterator fun(length: number, next: fun(idx: number))
local function rescheduleCrafting(event, iterator)
    -- validate
    local player = game.players[event.player_index]
    if not validatePlayer(player) then
        return
    end

    -- extend inventory size to prevent overflowing
    local inventory_bonus = player.character.character_inventory_slots_bonus
    player.character.character_inventory_slots_bonus = inventory_bonus + 1000

    -- cancel crafting
    local crafts = cancelCraftingQueue(player)

    -- reschedule crafting
    iterator(#crafts, function(idx)
        beginCrafting(player, crafts[idx])
    end)

    -- restore inventory size
    player.character.character_inventory_slots_bonus = inventory_bonus
end

script.on_event("promote-craft", function(event)
    rescheduleCrafting(--[[---@type]] event, function(length, next)
        next(1)
        for i = length, 2, -1 do
            next(i)
        end
    end)
end)

script.on_event("demote-craft", function(event)
    rescheduleCrafting(--[[---@type]] event, function(length, next)
        for i = length-1, 1, -1 do
            next(i)
        end
        next(length)
    end)
end)

script.on_event("reset-craft", function(event)
    rescheduleCrafting(--[[---@type]] event, function(length, next)
        for i = length, 1, -1 do
            next(i)
        end
    end)
end)