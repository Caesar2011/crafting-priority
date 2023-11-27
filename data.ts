import { type PrototypeData} from "factorio:common"
import {type CustomInputPrototype, type ShortcutPrototype} from "factorio:prototype"

declare const data: PrototypeData

data.extend<CustomInputPrototype|ShortcutPrototype>([
  {
    type: "custom-input",
    name: "promote-craft",
    key_sequence: "SHIFT + P",
    consuming: "game-only"
  } satisfies CustomInputPrototype,
  {
    type: "custom-input",
    name: "demote-craft",
    key_sequence: "SHIFT + D",
    consuming: "game-only"
  } satisfies CustomInputPrototype,
  {
    type: "custom-input",
    name: "reset-craft",
    key_sequence: "SHIFT + R",
    consuming: "game-only"
  } satisfies CustomInputPrototype,
  {
    type: "shortcut",
    name: "auto-reset-craft",
    toggleable: true,
    icon: {
      filename: "__base__/graphics/auto-craft-sprite.png",
      width: 32,
      height: 32,
    },
    action: "lua"
  } satisfies ShortcutPrototype
])