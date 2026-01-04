CardSleeves = CardSleeves or {}


SMODS.Joker{
    key = 'jimboGE',
	loc_txt = {
	name = "{C:wdylg_Gangster}Joker{}",
	text = {"{C:red,s:1.1}+#1#{} Bullets",
	"{C:attention}THIS IS NOT A MOVIE JOKER.{}"}
	},
	rarity = 3,
	depends = {"kino"},
	generate_ui = Kino and Kino.generate_info_ui or nil,
	pools, k_genre = {"Action", "Crime"},
	config = {extra = {bullet_count = 4, action = true}},
	cost = 9,
	atlas = 'wdylx',
	pos = {x = 0, y = 0},


	unlocked = true,
	discovered = false,
	loc_vars = function(self, info_queue, card)
     if G.P_CENTERS["j_kino_scarface_2"] ~= nil then self.kino_joker = G.P_CENTERS["j_kino_scarface_2"].kino_joker end
	return { vars = {self.config.extra.bullet_count or 4} }
	end,
    in_pool = function(self, args)
    return next(SMODS.find_mod("kino")) ~= nil
    end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge('Gangster Edition', G.C.BLACK, G.C.WHITE, 1 )
	end,
	calculate = function (self, card, context)
	local old_money_stolen = nil
	
	if context.before then
	old_money_stolen = G.GAME.money_stolen
	end
	if context.pre_joker and old_money_stolen > money_stolen and next(SMODS.find_card("j_kino_scarface_2")) then self.ability.extra.bullet_count = bullet_count + (G.GAME.money_stolen - old_money_stolen) end
	end
}


SMODS.Joker{
key = 'phrime',
loc_txt = {
name = 'Minos Phrime',
text = {'#1#/29 chance to...',
        'you should get it by now.'}
},
config = {extra = {canevolve = false}},
rarity = 3,
cost = 64,
unlocked = true,
discovered = false,
blueprint_compat = false,
eternal_compat = false,
perishable_compat = false,
atlas = 'wdylx',
pos = {x = 1, y = 0},
soul_pos = {x = 1, y = 1},

loc_vars = function(self, info_queue, card)
return { vars = {''..(G.GAME and G.GAME.probabilities.normal or 1)}}
end,

set_card_type_badge = function(self, card, badges)
	if next(SMODS.find_mod("busterb")) then
	badges[#badges+1] = create_badge('Fantastic?', G.C.SUITS.Spades, G.C.SECONDARY_SET.Enhanced, 1 )
	end
end,

in_pool = function(self, args)
    return not args or args.source == "jud"
end,

add_to_deck = function(self, card, from_debuff)
card.ability.extra.canevolve = next(SMODS.find_mod("busterb")) ~= nil
play_area_status_text("PHRIME GET!", false, 3.1)
end,

calculate = function(self,card,context)
if context.before and card.ability.extra.canevolve then
	G.E_MANAGER:add_event(Event({
		trigger = 'before',
		blocking = false,
		blockable = false,
func = function()
if math.max(pseudorandom("wdylg_phrime", 1, 29), 28) ~= 28 then 
play_area_status_text("Your Minos Phrime evolved into...", true)
card:set_ability("j_busterb_minosprime")
   end
  return true 
    end
}))
 
end

if context.setting_blind then
--oneshot vermillion virus please and phankyou
if context.blind.key == "bl_cry_vermillion_virus" then
G.GAME.blind.chips = 0
G.GAME.blind.chip_text = "OBLITERATED." --number_format(G.GAME.blind.chips)
G.GAME.chips = G.GAME.chips + 5
SMODS.juice_up_blind()
SMODS.add_card{key = "j_wdylg_phrime", edition = "negative"}

return {message = "DIE!", sound = "busterb_die" or "timpani", card = card}
end
end
if context.end_of_round and context.cardarea == G.jokers then
if not SMODS.last_hand_oneshot then
	local renpy = G.GAME.chips - G.GAME.blind.chips / (3 + G.GAME.round_resets.ante - 1)
	if math.floor(renpy) == renpy then
		local cardscreated = 0
		G.E_Manager:add_event(Event({
        trigger ='immediate',
		blocking = false,
		blockable = false,
		func = function ()
			add_tag(Tag('tag_juggle', false, 'Small'))
			if cardscreated >= renpy then return false else return true end
		end
	}))
	end
end
end
end
}

local idunnohowtosleeve = {
	key = "1MB",
	name = "Downsized Sleeve",
	--i dunno if theres a placeholder for missing image, so snatching the abandoned sleeve just in case.
    atlas = "casl_sleeve_atlas",
    pos = { x = 3, y = 1 },
	apply = function (self, sleeve)
     SMODS.create_card{key = "j_ring_master", edition = "e_negative", stickers = {"eternal"}}
	end,

	calculate = function (sleeve, context)
     if context.modify_shop_card then
		if context.card.ability.set == "Joker" and context.card.rarity ~= 1 then 
			if context.card.key == "j_wee" then return end
			context.card:set_ability(pseudorandom_element(G.P_JOKER_RARITY_POOLS[1], "wdylg_insertcheapshothere"))
	 end
	end
end
}

--Spare trousers: give a instance a special appearance if it has zirconium on it.

--Zirconium Pants: Same as above.

--elliot (sorry.. i can only do this with kino)

if next(SMODS.find_mod("casl")) then
	CardSleeves.Sleeve:register(idunnohowtosleeve)
end