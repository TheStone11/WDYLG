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

local j = {"code/contentfunc", "code/contentjokers", "code/styling", "code/ifstatementpurgatorio", "code/contentblinds", "code/contentAAAA", "code/contentresets"}

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

local jimbob = math.random(1, #WDYLG.static.pregametitles)
if jimbob == 23 then 
    love.system.openURL("https://tenor.com/view/spongebob-patrick-genaral-general-meme-gif-20239008")
end
love.window.setTitle("Balatro: ".. WDYLG.static.pregametitles[jimbob])



--[[
assert(SMODS.load_file("code/contentjokers.lua"))()
assert(SMODS.load_file("code/sytling.lua"))()
assert(SMODS.load_file("code/makingblindsmorehorrible.lua"))()
assert(SMODS.load_file("code/jokersad.lua"))()
]]