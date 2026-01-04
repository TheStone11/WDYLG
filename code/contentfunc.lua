
WDYLG = {}
WDYLG.ability = {}
function WDYLG.find(tabe, strin)
    --forgive me ___, for i have skidded
    for _, v in ipairs(table) do
	if v == strin then return v == strin end
	end
	return false
end

function WDYLG.valfunc(func, num1, num2, extra)
    local extar = extra or nil
local actions = {
    ["^"] = function()
        local watermelon = num1
        for i = 0, num2 do
            if extar and extar == "broken" then
            watermelon = watermelon * watermelon
            else
            watermelon = watermelon * num1
        end
    end
        return watermelon
    end
}

if actions[func] ~= nil then
return (actions[func]())
else
    return nil
    end
end

WDYLG.ability.WAAAAAARGH = function (caller)
for i = 1, G.jokers do 
   if G.jokers[i].config.center_key ~= caller.config.center_key then
   G.jokers[i].extra = copy_table(G.P_CENTERS[G.jokers[i].config.center_key].config.extra) or nil
   G.jokers[i].set_debuff(true)
   end
end
end

SMODS.Keybind{
    key_pressed = "G",

   action = function (self)
   if not G.GAME then return end
   if #G.jokers.highlighted == 0 then play_area_status_text("Select a joker to use its activated effect.", true) end
   for i = 1, #G.jokers.highlighted do if G.jokers.highlighted[i].WDYLG_hasability then G.jokers.highlighted[i]:calculate_joker{"USEABILITY"} end end
end

}