import {type LuaPlayer} from "factorio:runtime"
import {type ActivePlayer} from "./validate-player"

interface CraftingQueueItem {
  index: number;
  count: number;
  recipe: string;
}

function cancelCraftingQueue(player: LuaPlayer): CraftingQueueItem[] {
  const crafts: CraftingQueueItem[] = []
  let index = 0
  while (player.crafting_queue_size > 0) {
    index++
    const last_craft = player.crafting_queue[player.crafting_queue_size]
    crafts[index] = last_craft
    player.cancel_crafting({index: last_craft.index, count: last_craft.count})
  }
  return crafts
}

function beginCrafting(player: LuaPlayer, craft: CraftingQueueItem): void {
  player.begin_crafting({count: craft.count, recipe: craft.recipe, silent: false})
}

export function rescheduleCrafting(player: ActivePlayer, iterator: (length: number, next: (idx: number) => void) => void): void {
  // extend inventory size to prevent overflowing
  const inventory_bonus = player.character.character_inventory_slots_bonus
  player.character.character_inventory_slots_bonus = inventory_bonus + 10000

  // cancel crafting
  const crafts = cancelCraftingQueue(player)

  // reschedule crafting
  iterator(crafts.length, function (idx: number) {
    beginCrafting(player, crafts[idx])
  })
  // restore inventory size
  player.character.character_inventory_slots_bonus = inventory_bonus
}