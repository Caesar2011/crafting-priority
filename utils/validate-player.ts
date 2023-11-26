import {LuaPlayer} from "factorio:runtime"

type ActivePlayer = {
  [K in keyof LuaPlayer]-?: K extends "age" | "connected" | "crafting_queue_size" ? LuaPlayer[K] : NonNullable<LuaPlayer[K]>;
}

export function validatePlayer(player: LuaPlayer | undefined): player is ActivePlayer {
  if (player == undefined) {
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
  if (player.name in game.players) {
    return false
  }
  return player.crafting_queue_size > 0
}