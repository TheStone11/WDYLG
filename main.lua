SMODS.Atlas{
key = 'wdylj',
px = 71,
py = 95,
path = 'whyjokers.png'
}
SMODS.Atlas{
key = 'wdylx',
px = 71,
py = 95,
path = 'whyjokerscross.png'
}
SMODS.Atlas{
key = 'wdylhlf',
px = 71,
py = 63,
path = 'halfjokers.png'
}
SMODS.Atlas{
key = 'wdylc',
px = 71,
py = 95,
path = 'whyconsumables.png'
}
SMODS.Atlas{
key = 'downsized',
px = 71,
py = 95,
path = 'downsized.png'
}
SMODS.Sound{
    key = 'wega',
    path = 'thanksmyinstants.ogg'
}
SMODS.Sound{
    key = 'tuco',
    path = 'tewcone.ogg'
}
SMODS.Sound{
    key = 'squeak',
    path = 'squeak.ogg'
}
SMODS.Sound{
    key = 'womp',
    path = 'bowomp.ogg'
}
SMODS.Sound{
    key = 'bows',
    path = 'smw_bowser_returns.ogg'
}
--end of arrays

--file loading

local j = {"code/contentjokers", "code/styling", "code/ifstatementpurgatorio", "code/contentblinds", "code/contentfunc", "code/contentAAAA", "code/contentresets"}

for i,v in pairs(j) do
assert(SMODS.load_file(v..".lua"))()
end


SMODS.current_mod.optional_features = {

    post_trigger = true,

cardareas = {
        discard = true,
        deck = true
    }
}

love.window.setTitle("Balatro: ".. WDYLG.static.pregametitles[math.random(1, #WDYLG.static.pregametitles)])

SMODS.current_mod.reset_game_globals = function (run_start)
 if love.window.getTitle( ) ~= "Balatro" then love.window.setTitle("Balatro") end
if run_start then G.GAME.WDYLG = {} 
G.GAME.WDYLG.hiddenhands = {"cry_None"}
 for i, v in pairs(G.GAME.hands) do if v.visible == false and not WDYLG.find(G.GAME.WDYLG.hiddenhands, i) == false then table.insert(G.GAME.WDYLG.hiddenhands, i) end end
G.GAME.WDYLG.chaosemeraldgone = false
check_for_unlock({type = 'wdylg_also_unlock'})
end
end


--[[
assert(SMODS.load_file("code/contentjokers.lua"))()
assert(SMODS.load_file("code/sytling.lua"))()
assert(SMODS.load_file("code/makingblindsmorehorrible.lua"))()
assert(SMODS.load_file("code/jokersad.lua"))()
]]