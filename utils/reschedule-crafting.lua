local a={}local b=require("utils.validate-player")local c=b.validatePlayer;local function d(e)local f={}local g=0;while e.crafting_queue_size>0 do g=g+1;local h=e.crafting_queue[e.crafting_queue_size+1]f[g+1]=h;e.cancel_crafting({index=h.index,count=h.count})end;return f end;local function i(e,j)e.begin_crafting({count=j.count,recipe=j.recipe,silent=false})end;function a.rescheduleCrafting(e,k)if not c(e)then return end;local l=e.character.character_inventory_slots_bonus;e.character.character_inventory_slots_bonus=l+10000;local f=d(e)k(#f,function(m)i(e,f[m+1])end)e.character.character_inventory_slots_bonus=l end;return a
