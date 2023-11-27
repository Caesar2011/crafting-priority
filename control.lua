--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____iterators = require("utils.iterators")
local demoteIterator = ____iterators.demoteIterator
local promoteIterator = ____iterators.promoteIterator
local sameOrderIterator = ____iterators.sameOrderIterator
local ____reschedule_2Dcrafting = require("utils.reschedule-crafting")
local rescheduleCrafting = ____reschedule_2Dcrafting.rescheduleCrafting
local ____helper = require("utils.helper")
local debounce = ____helper.debounce
local onTickUpdateDebounce = ____helper.onTickUpdateDebounce
local ____validate_2Dplayer = require("utils.validate-player")
local validatePlayer = ____validate_2Dplayer.validatePlayer
script.on_event(
    "promote-craft",
    function(event)
        local player = game.players[event.player_index]
        if not validatePlayer(player) then
            return
        end
        rescheduleCrafting(player, promoteIterator)
    end
)
script.on_event(
    "demote-craft",
    function(event)
        local player = game.players[event.player_index]
        if not validatePlayer(player) then
            return
        end
        rescheduleCrafting(player, demoteIterator)
    end
)
script.on_event(
    "reset-craft",
    function(event)
        local player = game.players[event.player_index]
        if not validatePlayer(player) then
            return
        end
        rescheduleCrafting(player, sameOrderIterator)
    end
)
local debouncedOnChange = debounce(
    "on-inv-changed",
    30,
    function(____bindingPattern0)
        local event
        event = ____bindingPattern0[1]
        local player = game.players[event.player_index]
        if not validatePlayer(player) then
            return
        end
        if player.is_shortcut_toggled("auto-reset-craft") then
            rescheduleCrafting(player, sameOrderIterator)
        end
    end
)
script.on_event(
    defines.events.on_player_main_inventory_changed,
    function(event) return debouncedOnChange({event}) end
)
script.on_nth_tick(
    30,
    function(event)
        onTickUpdateDebounce(event.tick)
    end
)
return ____exports
