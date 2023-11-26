import {PrototypeData} from "factorio:common"
import {CustomInputPrototype} from "factorio:prototype"

declare const data: PrototypeData

data.extend([
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
  } satisfies CustomInputPrototype
])