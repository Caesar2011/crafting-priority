---@type fun(event: CustomInputEvent)

local function validate_player(player)
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
    return true
end

local function promoteCraft(event)
    local player = game.players[event.player_index]
    if not validate_player(player) and player.crafting_queue_size == 0 then
        return nil
    end

    ---@type CraftingQueueItem[]
    local crafts = {}
    local index = 1
    while player.crafting_queue_size > 0 do
        local last_craft = player.crafting_queue[player.crafting_queue_size]
        crafts[index] = last_craft
        player.cancel_crafting{index=last_craft.index, count=last_craft.count}
        index = index + 1
    end
    index = index - 1

    local next_craft = crafts[1]
    player.begin_crafting{count=next_craft.count, recipe=next_craft.recipe, silent=False}


    for remake_index = index, 2, -1 do
        next_craft = crafts[remake_index]
        player.begin_crafting{count=next_craft.count, recipe=next_craft.recipe, silent=False}
    end
end
script.on_event("promote-craft", promoteCraft)


---@type fun(event: CustomInputEvent)
local function demoteCraft(event)
    local player = game.players[event.player_index]
    if not validate_player(player) and player.crafting_queue_size == 0 then
        return nil
    end

    ---@type CraftingQueueItem[]
    local crafts = {}
    local index = 1
    while player.crafting_queue_size > 0 do
        local last_craft = player.crafting_queue[player.crafting_queue_size]
        crafts[index] = last_craft
        player.cancel_crafting{index=last_craft.index, count=last_craft.count}
        index = index + 1
    end
    index = index - 1

    for remake_index = index-1, 1, -1 do
        local next_craft = crafts[remake_index]
        player.begin_crafting{count=next_craft.count, recipe=next_craft.recipe, silent=False}
    end
    next_craft = crafts[index]
    player.begin_crafting{count=next_craft.count, recipe=next_craft.recipe, silent=False}

end
script.on_event("demote-craft", demoteCraft)


---@type fun(event: CustomInputEvent)
local function resetCraft(event)
    local player = game.players[event.player_index]
    if not validate_player(player) and player.crafting_queue_size == 0 then
        return nil
    end


    local crafts = {}
    local index = 1
    while player.crafting_queue_size > 0 do
        local last_craft = player.crafting_queue[player.crafting_queue_size]
        crafts[index] = last_craft
        player.cancel_crafting{index=last_craft.index, count=last_craft.count}
        index = index + 1
    end
    index = index - 1

    for remake_index = index, 1, -1 do
        next_craft = crafts[remake_index]
        player.begin_crafting{count=next_craft.count, recipe=next_craft.recipe, silent=False}
    end

end
script.on_event("reset-craft", resetCraft)

