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

SMODS.current_mod.optional_features = {

    post_trigger = true,

cardareas = {
        discard = true,
        deck = true
    }
}

--file loading

local j = {"code/contentjokers", "code/styling", "code/ifstatementpurgatorio", "code/contentblinds", "code/contentfunc", "code/contentAAAA"}

for i,v in pairs(j) do
assert(SMODS.load_file(v..".lua"))()
end

--[[
assert(SMODS.load_file("code/contentjokers.lua"))()
assert(SMODS.load_file("code/sytling.lua"))()
assert(SMODS.load_file("code/makingblindsmorehorrible.lua"))()
assert(SMODS.load_file("code/jokersad.lua"))()
]]