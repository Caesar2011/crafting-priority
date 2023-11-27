--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local debouncedFunctions = {}
function ____exports.debounce(id, delayTicks, func)
    return function(args)
        debouncedFunctions[id] = {
            executeAtTick = game.tick + delayTicks,
            fn = function()
                func(args)
                debouncedFunctions[id] = nil
            end
        }
    end
end
function ____exports.onTickUpdateDebounce(currentTick)
    for key in pairs(debouncedFunctions) do
        local value = debouncedFunctions[key]
        if value ~= nil and value.executeAtTick < currentTick then
            value:fn()
        end
    end
end
return ____exports
