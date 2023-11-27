--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local function cancelCraftingQueue(player)
    local crafts = {}
    local index = 0
    while player.crafting_queue_size > 0 do
        index = index + 1
        local last_craft = player.crafting_queue[player.crafting_queue_size + 1]
        crafts[index + 1] = last_craft
        player.cancel_crafting({index = last_craft.index, count = last_craft.count})
    end
    return crafts
end
local function beginCrafting(player, craft)
    player.begin_crafting({count = craft.count, recipe = craft.recipe, silent = false})
end
function ____exports.rescheduleCrafting(player, iterator)
    local inventory_bonus = player.character.character_inventory_slots_bonus
    player.character.character_inventory_slots_bonus = inventory_bonus + 10000
    local crafts = cancelCraftingQueue(player)
    iterator(
        #crafts,
        function(idx)
            beginCrafting(player, crafts[idx + 1])
        end
    )
    player.character.character_inventory_slots_bonus = inventory_bonus
end
return ____exports
