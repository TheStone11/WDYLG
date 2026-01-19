CardSleeves = CardSleeves or {}
BLINDSIDE = BLINDSIDE or {}

local gangstereditionref = {
    key = 'jimboGE',
	loc_txt = {
	name = "{C:wdylg_Gangster}Joker{}",
	text = {"{C:red,s:1.1}+#1#{} Bullets",
	"{C:attention}THIS IS NOT A MOVIE JOKER.{}"}
	},
	rarity = 3,
	k_genre = {"Action", "Crime"},
	config = {extra = {bullet_count = 4, action = true}},
	cost = 9,
	atlas = 'wdylx',
	pos = {x = 0, y = 0},
    no_collection = not next(SMODS.find_mod("kino")) ~= nil,

	unlocked = true,
	discovered = false,
	loc_vars = function(self, info_queue, card)
	return { vars = {card.config.extra.bullet_count or 4} }
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
	if context.pre_joker and old_money_stolen > money_stolen and next(SMODS.find_card("j_kino_scarface_2")) then card.ability.extra.bullet_count = card.ability.extra.bullet_count + (G.GAME.money_stolen - old_money_stolen) end
	end
}

if next(SMODS.find_mod("kino")) then
gangstereditionref.kino_joker = G.P_CENTERS["j_kino_scarface_2"].kino_joker
gangstereditionref.generate_ui = Kino.generate_info_ui

end
SMODS.Joker(gangstereditionref)

SMODS.Joker{
key = 'phrime',
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
return { vars = {''..(G.GAME and G.GAME.probabilities.normal or 1)},key = next(SMODS.find_mod("busterb")) ~= nil and "j_wdylg_phrime_crossmod" or nil}
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
if G.GAME.blind.config.blind.key == "bl_cry_vermillion_virus" then
G.GAME.blind.chips = 0
G.GAME.blind.chip_text = "OBLITERATED." --number_format(G.GAME.blind.chips)
G.GAME.chips = G.GAME.chips + 5
SMODS.juice_up_blind()
SMODS.add_card{key = "j_wdylg_phrime", edition = "negative"}
G:update_new_round()
return {message = "DIE!", sound = "busterb_die" or "timpani", card = card}
end
end
if context.end_of_round and context.cardarea == G.jokers then
if not SMODS.last_hand_oneshot then
	local renpy = G.GAME.chips - G.GAME.blind.chips / (3 + G.GAME.round_resets.ante - 1)
	if round_number(renpy, 1) == renpy then
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

SMODS.Joker{
	key = "zyal",
	loc_txt = {
      name = "1x1x1x1 bouncing",
	  text = {"4 glop."}
	},
	no_collection = not next(SMODS.find_mod("potassium_re")) ~= nil,
      in_pool = function(self, args)
    return next(SMODS.find_mod("potassium_re")) ~= nil
    end,
	rarity = 4,
	cost = 0,
	
	calculate = function (self, card, context)
		if context.individual and context.cardarea == "unscored" then
			return{
				glop = 4
			}
		end
	end
}


SMODS.Voucher{
key = "lesh",
loc_txt = {
name = "Leshy's Camera",
text = {"Finity and grab bag boss jokers are free."} 
},
config = {extra = {"finity_boss", "gb_boss"}},
cost = 12,
no_collection = not (next(SMODS.find_mod("finity")) ~= nil or next(SMODS.find_mod("GrabBag")) ~= nil),
in_pool = function (self, args)
	return next(SMODS.find_mod("finity")) ~= nil or next(SMODS.find_mod("GrabBag")) ~= nil
end,

calculate = function (self, card, context)
if context.modify_shop_card then
	if WDYLG.find(card.config.extra, context.card.rarity) then
		context.card.ability.couponed = true
		context.card:set_cost()
	end
end
end

}

local idunnohowtosleeve = {
	key = "1MB",
	atlas = 'downsized',
	loc_txt = {
		name = "Downsized Sleeve",
		text = {"ONLY COMMONS IN THE BUILDING!",
	            "{X:inactive,C:default,s:0.10}And maybe wee joker.{}"}
	},
	config = {jokers = {'j_ring_master'}},
	pos = {x = 0, y = 0},

	calculate = function (sleeve, context)
     if context.modify_shop_card then
		if context.card.ability.set == "Joker" and context.card.rarity ~= 1 then 
			if context.card.key == "j_wee" then return end
			context.card:set_ability(pseudorandom_element(G.P_JOKER_RARITY_POOLS[1], "wdylg_insertcheapshothere"))
	 end
	end
end
}

local needles = {
	key = "needlebox",
	loc_txt = {
		name = "Needle Planterbox",
		text = {"At the end of each boss blind:",
	            "Gives you a needle blindchip."}
	},
	rarity = 'bld_keepsake',
	cost = 12,
	blueprint_compat = false,
	--code copied from blindside in particular :P
	  in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
		calcuate = function (self, card, context)
			if context.blind_defeated and context.blind.boss ~= nil then
				SMODS.create_card({set = 'Playing Card', enhancement = "m_bld_needle", soulable = card.soulable})
				return {message = "Harvested"}
			end
		end
}

if next(SMODS.find_mod("CardSleeves")) then
CardSleeves.Sleeve(idunnohowtosleeve)
end
if next (SMODS.find_mod("blindside")) then
	BLINDSIDE.BLIND(needles)
end

--next up is take_ownership

--the godsmarble from hit mod busted buffoons was eradicated along with the PSI crossmod. this comment will remain.

WDYLG.catblacklist = {
	"Cat",
	"Kitties",
	"kity",
	"friends_of_astro",  --if this hits any false positives dm me.
	 "ElementCattosCommon",
	 "ElementCattosUncommon",
	 "ElementCattosRare",
	 "ElementCattosLegendary"
}
--BREAKING NEWS, LOCAL ROCK DESTROYS ENTIRE MYTHOS, DECLARING ALL CATS "IMPOSTORS"
--false positives are inevitable.
--joke stolen from https://www.youtube.com/watch?v=iqP3vCAylFY&lc=UgwImg9ud5Y4vR8KDbh4AaABAg
-- 50/50s are a pain, for that reason bozo from horizon needs to be cnfirmed somehow....
WDYLG.catblacklistspecific = {
	--and now the hunt begins.
	"j_ortalab_black_cat",
	"minty_3s",
	"j_cry_kittyprinter",
	"j_cry_yarnball",
	"j_lucky_cat",
	"j_hpot_smods",
	"j_gj_fireicerealjokerlol",
	"j_gj_pr",
	"j_gj_gudDetri", --possible falsepositive
	"j_nflame_localfunc",
	"j_flynnset_cat",
	"j_flynnset_bingus",
	"j_dandy_scraps",
	"j_dw_fireice",
	"j_dw_iso",
	"j_dw_tw_iso",
	"j_hodge_disappearingguy",
	"j_hodge_lumi",
	"j_ocstobal_solinium",
	"j_ocstobal_solawk",
	"j_ocstobal_solawkclassic",
	"j_ocstobal_crystal",
     "j_ocstobal_xeno",
	 "j_star_colon3c",
	 "j_cry_yarnball",
	 "mtg_mtg-jetmir",
	 "j_poke_billion_lions",
	 "j_poke_meowth",
	 "j_poke_persian",
	 "j_poke_mew",
	 "j_poke_mewtwo",
	 "j_poke_mega_mewtwo_x",
	 "j_poke_mega_mewtwo_y",
	 "j_poke_raikou",
	 "j_poke_skitty",
	 "j_poke_delcatty",
	 "j_poke_sneasel",
	 "j_poke_weavile",
	 "j_poke_sneasler",
	 "j_poke_litleo",
	 "j_poke_pyroar",
	 "j_felijo_feli_leg",
	 "j_fams_bigboobs", --aka. maxwell, and/or uni.
	 "j_phanta_snoinches",
    --dont worry about that other rainworld joker mod, i have a secret weapon for it.
		--im catching revo's vault if it ever releases the vanilla slugcats
	"j_rwjkrs_rivulet",
	"j_rwjkrs_saint",
	"j_rwjkrs_hunter",
	"j_rwjkrs_hllegs", --andd i was forced to make a spoiler... I STILL CANT POST THE VIDEO


	--these cats(?) are fucked up yog :sob:
	"j_fur_danny",
	"j_fur_talismancorruptdanny",
	"j_fur_corruptdanny",
	"j_fur_talismandanny",
	"j_fur_koneko",
	"j_unik_catto_boi",
	"j_unik_niko",
	"j_unik_jsab_chelsea",
	"j_unik_jsab_yokana",
	"j_unik_jsab_maya",
	"j_unik_unik",
	"j_unik_last_tile",
    "j_unik_copycat",
	"j_unik_uniku",
	"j_unik_scratch",
    "j_busterb_a_unik",
	--the section which contains every astro card found for no reason at all.
	"j_busterb_astro",
	"j_tngt_astro",
	"j_lzh_astro",
	"j_para_astro",
	"j_ocstobal_astro",
	"j_xiferp_astro_card",
	"j_flynnset_astro"
	--further on this point uses a autofill.
}

if next(SMODS.find_mod("yahimod")) then 
SMODS.Blind:take_ownership("yahimod_boss_alcatraz", {
recalc_debuff = function(self, card)
        for i = 1, #G.jokers.cards do
            if not G.GAME.blind.disabled and G.jokers.cards[i].config.center.pools then 
				local dodebuff = false
				for c = 1, #G.jokers.cards[i].config.center.pools do if WDYLG.find(WDYLG.catblacklist, G.jokers.cards[i].config.center.pools[c]) then dodebuff = true break end end
				if WDYLG.find(G.GAME.WDYLG.catblacklist, G.jokers.cards[i].config.center_key) then dodebuff = true end
				dodebuff = G.jokers.cards[i]:is_rarity("meow_cat_rarity")
                G.jokers.cards[i]:set_debuff(dodebuff)
            end
        end
    end,
}, true)
end