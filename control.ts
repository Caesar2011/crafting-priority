import {demoteIterator, promoteIterator, sameOrderIterator} from "./utils/iterators"
import {rescheduleCrafting} from "./utils/reschedule-crafting"
import {debounce, onTickUpdateDebounce} from "./utils/helper"
import {type OnPlayerMainInventoryChangedEvent} from "factorio:runtime"
import {validatePlayer} from "./utils/validate-player"

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

const debouncedOnChange = debounce("on-inv-changed", 30, ([event]: [OnPlayerMainInventoryChangedEvent]) => {
  const player = game.players[event.player_index]
  if (!validatePlayer(player)) return
  if (player.is_shortcut_toggled("auto-reset-craft"))
    rescheduleCrafting(player, sameOrderIterator)
})
script.on_event(defines.events.on_player_main_inventory_changed, event => debouncedOnChange([event]))

script.on_nth_tick(30, event => {
  onTickUpdateDebounce(event.tick)
})
