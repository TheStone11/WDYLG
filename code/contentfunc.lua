
WDYLG = {}
WDYLG.ability = {}
WDYLG.static = {}
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


local i_dunno_how_to_sell = G.FUNCS.sell_card

function G.FUNCS.sell_card(e)
  local card = e.config.ref_table
  SMODS.calculate_context({before_sell = true, card = card})
  local ret = i_dunno_how_to_sell(e)
  return ret
end

if not next(SMODS.find_mod("LAPSEMS")) then
    WDYLG.change_blind_color = function(new_color)
    Blind:change_colour(new_color) -- Blind box
    ease_background_colour{new_colour = new_color} -- Background
end --The creator of why do you like general thanks lapsem_ for letting him use their function.
end