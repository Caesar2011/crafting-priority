--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.promoteIterator(length, next)
    if length ~= 0 then
        next(1)
    end
    do
        local i = length
        while i >= 2 do
            next(i)
            i = i - 1
        end
    end
end
function ____exports.demoteIterator(length, next)
    do
        local i = length - 1
        while i >= 1 do
            next(i)
            i = i - 1
        end
    end
    if length ~= 0 then
        next(length)
    end
end
function ____exports.sameOrderIterator(length, next)
    do
        local i = length
        while i >= 1 do
            next(i)
            i = i - 1
        end
    end
end
return ____exports
