import {type LuaPlayer} from "factorio:runtime"

export type ActivePlayer = {
  [K in keyof LuaPlayer]-?: K extends "age" | "connected" | "crafting_queue_size" ? LuaPlayer[K] : NonNullable<LuaPlayer[K]>;
}

export function validatePlayer(player: LuaPlayer | undefined): player is ActivePlayer {
  if (player === undefined) {
    return false
  }
  if (!player.valid) {
    return false
  }
  if (player.character == null) {
    return false
  }
  if (!player.connected) {
    return false
  }
  if (game.players[player.name] === undefined) {
    return false
  }
  return player.crafting_queue_size > 0
}