import {demoteIterator, promoteIterator, sameOrderIterator} from "./utils/iterators"
import {rescheduleCrafting} from "./utils/reschedule-crafting"

script.on_event("promote-craft", function(event) {
  rescheduleCrafting(game.players[event.player_index], promoteIterator)
})

script.on_event("demote-craft", function(event) {
  rescheduleCrafting(game.players[event.player_index], demoteIterator)
})

script.on_event("reset-craft", function(event) {
  rescheduleCrafting(game.players[event.player_index], sameOrderIterator)
})
