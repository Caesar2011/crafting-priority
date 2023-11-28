import {demoteIterator, promoteIterator, sameOrderIterator} from "./utils/iterators"
import {rescheduleCrafting} from "./utils/reschedule-crafting"
import {type ActivePlayer, validatePlayer} from "./utils/validate-player"
import {debounce, onTickUpdateDebounce} from "./utils/helper"
import {type PlayerIndex} from "factorio:runtime"

// Basic functionality to update the queue

script.on_event("promote-craft", function(event) {
  const player = game.players[event.player_index]
  if (!validatePlayer(player)) return
  rescheduleCrafting(player, promoteIterator)
})

script.on_event("demote-craft", function(event) {
  const player = game.players[event.player_index]
  if (!validatePlayer(player)) return
  rescheduleCrafting(player, demoteIterator)
})

script.on_event("reset-craft", function(event) {
  const player = game.players[event.player_index]
  if (!validatePlayer(player)) return
  rescheduleCrafting(player, sameOrderIterator)
})

// Auto-reset crafting toggle

// on shortcut click
script.on_event(defines.events.on_lua_shortcut, event => {
  if (event.prototype_name === "auto-reset-craft") toggleAutoCraft(event.player_index)
})

// on keybinding
script.on_event("auto-reset-craft", event => {
  toggleAutoCraft(event.player_index)
})

function toggleAutoCraft(playerIdx: PlayerIndex) {
  const player = game.players[playerIdx]
  if (!validatePlayer(player)) return
  player.set_shortcut_toggled("auto-reset-craft", !player.is_shortcut_toggled("auto-reset-craft"))
}

const debouncedFinishCrafting = debounce("finished-crafting", 3, (player: ActivePlayer) => {
  rescheduleCrafting(player, sameOrderIterator)
})
script.on_event(defines.events.on_player_crafted_item, event => {
  const player = game.players[event.player_index]
  if (!validatePlayer(player) || !player.is_shortcut_toggled("auto-reset-craft")) return
  debouncedFinishCrafting(player)
})

script.on_nth_tick(1, event => {
  onTickUpdateDebounce(event.tick)
})
