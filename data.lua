--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
data:extend({{type = "custom-input", name = "promote-craft", key_sequence = "SHIFT + P", consuming = "game-only"}, {type = "custom-input", name = "demote-craft", key_sequence = "SHIFT + D", consuming = "game-only"}, {type = "custom-input", name = "reset-craft", key_sequence = "SHIFT + R", consuming = "game-only"}, {
    type = "shortcut",
    name = "auto-reset-craft",
    toggleable = true,
    icon = {filename = "__base__/graphics/auto-craft-sprite.png", width = 32, height = 32},
    action = "lua"
}})
return ____exports
