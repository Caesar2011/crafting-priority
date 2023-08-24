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
---@param getOrderGen fun(length: number): thread
local function rescheduleCrafting(event, getOrderGen)
    -- validate
    local player = game.players[event.player_index]
    if not validatePlayer(player) then
        return
    end

    -- cancel crafting
    local crafts = cancelCraftingQueue(player)

    -- reschedule crafting
    local orderGen = getOrderGen(#crafts)
    while true do
        local status, value = coroutine.resume(orderGen)
        if not status then
            break
        end
        beginCrafting(player, crafts[value])
    end
end

script.on_event("promote-craft", function(event)
    rescheduleCrafting(--[[---@type]] event, function(length)
        return coroutine.create(function()
            coroutine.yield(1)
            for i = length, 2, -1 do
                coroutine.yield(i)
            end
        end)
    end)
end)

script.on_event("demote-craft", function(event)
    rescheduleCrafting(--[[---@type]] event, function(length)
        return coroutine.create(function()
            for i = length-1, 1, -1 do
                coroutine.yield(i)
            end
            coroutine.yield(length)
        end)
    end)
end)

script.on_event("reset-craft", function(event)
    rescheduleCrafting(--[[---@type]] event, function(length)
        return coroutine.create(function()
            for i = length, 1, -1 do
                coroutine.yield(i)
            end
        end)
    end)
end)