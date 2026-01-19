JoyousSpring = JoyousSpring or {}


SMODS.Joker{
    key = 'weaponization',
	loc_txt = {
	name = 'Weaponization of Sealed Emancipation',
    text = {"My bad wanted to lose naming convention.",
	        "Quarter of Multiplier ALSO goes towards round score"},
	unlock = {"You dont."}
	},
	rarity = 4,
	unlocked = false,
	discovered = false,
	cost = 15,
	atlas = 'wdylj',
	pos = {x = 4, y = 0},
	--2 0
	config = {extra = {scoremult = 0.25, cutoffpoint = 1},},

loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.scoremult, card.ability.extra.cutoffpoint} }
	end,
	
  calculate = function (self, card, context)
    if context.post_joker then
  local cfp = card.ability.extra.cutoffpoint
  local scmult = card.ability.extra.scoremult
  local current_hand_mult = mult
	if math.min(cfp, current_hand_mult) ~= cfp and math.min(cfp, G.GAME.chips) ~= cfp then
    if round_number(current_hand_mult * scmult, 0) > cfp then
	local lsh = (G.GAME.chips * round_number(current_hand_mult * scmult, 0)) - G.GAME.chips
	G.GAME.chips = G.GAME.chips + lsh
	ease_chips(lsh)
	WDYLG.usequote = true
	 end
    end
	if context.after then
	if SMODS.last_hand_oneshot and WDYLG.usequote then return {message = 'Once agin I have cut a worthless object.', card = card}end
	WDYLG.usequote = false
	end
	end
	end
}

SMODS.Joker{
    key = 'wcards',
	loc_txt = {
	name = "LosPollos & Wad",
	text = {"Create a {C:attention}Judgement{} at the end of every blind.",
	        "card idea and image from: CoolFlynn"}
	},
	rarity = 3,
	cost = 9,
	atlas = 'wdylj',
	pos = {x = 1, y = 0},
	unlocked = true,
	discovered = false,
calculate = function (self, card, context)
if context.end_of_round and (not context.game_over) and #G.consumeables.cards < G.consumeables.config.card_limit and context.main_eval then
G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
SMODS.add_card{key = "c_judgement", area = G.consumeables}
G.GAME.consumeable_buffer = 0
juice_card(card)
return {message = "W CARDS?", card = card}
end

--[[
if context.using_consumeable and context.card_added and context.cardarea == G.jokers and context.consumable.key == "Judgement" then
juice_card(card)
if context.card.rarity < 3 then return {message = "L cards...", card = card} else return {message = "W CARDS!", card = card} end
end
]]
end


}


SMODS.Joker{
key = 'angry',
loc_txt = {
	name = "Mad Sackboy",
	text = {"Why is he so mad?",
	        "card idea from: Boltborn and cakesterbakester"}
	},
	config = {eternal = true},
	unlocked = true,
	discovered = true,
	rarity = 1,
	cost = 0,
	atlas = 'wdylj',
	pos = {x = 2, y = 0},
	
in_pool = function(self, args)
    return not args or args.source == "jud"
end,
	
set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge(':SKULL:', G.C.SUITS.Hearts, G.C.red, 1 )
end,

calculate = function (self, card, context)
if context.joker_main then

local llose = function ()
 if not next(SMODS.find_card("j_mr_bones")) then 
 remove_save() 
  love = nil 
  else
  for i = 1, G.jokers.cards do
	if G.jokers[i].config.center_key == "j_mr_bones" then
		 G.jokers[i]:shatter() 
		 break
end
  end
  end
 end 

if math.random(1,2) == 1 then
local yerm = mult
return  { mult = WDYLG.valfunc("^", yerm, 5, "broken") }
else
llose()
end
end
end
}

SMODS.Joker{
key = 'oldman',

--Gerson will borrow your consumables at the start of every blind (a consumable will be skipped if its negative already.), after clearing the blind: he will return your consumables with negative added.
loc_txt = {
name = 'Gerson',
text = {"I think HE'S OLD!",
"Anyways, he turns your existing consumables negative, if they arent already.",
"idea from ElpaoloXD587."},
unlock = {"Go get perkeo first."}},
config = {extra = { borrowed = {} } },
unlocked = false,
discovered = false,
blueprint_compat = false,
eternal_compat = true,
perishable_compat = false,
rarity = 3,
atlas = 'wdylj',
pos = {x = 6, y = 0},

check_for_unlock = function (self, args)
	if args.type == "wdylg_also_unlock" then
	if G.P_CENTERS["j_perkeo"].unlocked then
		unlock_card(self)
	end
end
end,

calculate = function (self, card, context)
	local contexttext = 0
if context.setting_blind then
 for i, v in ipairs(G.consumeables.cards) do
	if not v.edition then
		table.insert(card.ability.extra.borrowed, v.config.center_key)
		SMODS.destroy_cards(v)
		contexttext = contexttext + 1
	end
 end
 if contexttext > 0 then return {message = "*Borrowed "..contexttext.."*"} end
 contexttext = 0
 end

if context.blind_defeated then
    for i, v in ipairs(card.ability.extra.borrowed) do
		local turtledelivery = SMODS.create_card{key = v, edition = 'e_negative'}
		turtledelivery:add_to_deck()
		G.consumeables:emplace(turtledelivery)
		contexttext = contexttext + 1
	end
	if contexttext > 0 then return {message = "*Returned "..contexttext.."*"} end
 contexttext = 0
	card.ability.extra.borrowed = {}
 end
end
}

SMODS.Joker{
key = 'wega',

loc_txt = {
name =  "Wega Idol",
text = {"You shouldn't have this.",
        "#1# in #2# chance for {X:mult,C:white}#3# Mult, {C:attention}ALTHOUGH{}..."}
},
config = {extra = {probability = 20, jumpmult = 1, uhh = 0}},
unlocked = true,
discovered = false,
blueprint_compat = false,
eternal_compat = true,
perishable_compat = false,
rarity = 3,
price = 7,
atlas = 'wdylj',
pos = {x = 6, y = 0},
loc_vars = function(self,info_queue,card)
        return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.probability or 20, card.ability.extra.jumpmult or 1} }
	end,
calculate = function (self,card,context)

if context.before and context.cardarea == G.jokers then
if pseudorandom("wega", G.GAME.probabilities.normal, card.ability.extra.probability) ~= card.ability.extra.probability then
	card.ability.extra.uhh = card.ability.extra.uhh + 1
    card.ability.extra.probability = card.ability.extra.probability - 2

	card.ability.extra.jumpmult = card.ability.extra.jumpmult + (1 + (2 ^ card.ability.extra.uhh))
else
	WDYLG.ability.WAAAAAARGH(card)
	local temp = card.ability.extra.jumpmult
	card.ability.extra.jumpmult = 1
	card.ability.extra.probability = 20
	return {mult = card.ability.extra.jumpmult, sound = 'wdylg_wega'}
end
end
end
}

--[[
SMODS.Joker{
key = 'foolsday',

loc_txt = {
name = "Foolprint",
text = {"Retriggers consumeables"}
},
unlocked = true,
discovered = false,
blueprint_compat = true,
eternal_compat = true,
perishable_compat = false,
pos = {x = 6, y = 0},

calculate = function (self, card, context)
if context.using_consumeable then
	local repeated = context.consumeable
	local whyamihere = context.area
	repeat love.timer.sleep(0.7) until not context.using_consumeable
	if repeated ~= nil then
	repeated:use_consumeable(whyamihere, card)
	end
end
end
}
]]
SMODS.Joker{
	key = 'artіfact',

	loc_txt = {
		name = "Legendary Artifact.",
		text = {"You are GOING to like this."},
		unlock = {"???"}
	},
		atlas = 'wdylhlf',
	pos = {x = 6, y = 0},
	pixel_size = {w = 71, h = 65},
	display_size = {w = 71, h = 63},
	unlocked = false,
	discovered = false,
	rarity = 4,
    blueprint_compat = false,
  in_pool = function (self, args)
	return self.unlocked
  end,
  set_card_type_badge = function(self, card, badges)
   badges[#badges+1] = create_badge('GENUINE.', G.C.SUITS.Spades, G.C.SECONDARY_SET.Enhanced, 1)
  end,

	calculate = function (self, card, context)
     if context.joker_main then
		local LETSGO = tonumber(0)
		local l1 = 0
		local l2 =  G.GAME.round_resets.ante
		local l3 = #G.play.cards
        for  i = 1, l3 do
			l1 = l1 + G.play.cards[i].base.nominal
		end
        for i = 0, l3 do
			LETSGO = LETSGO + (l1 ^ l2)
			if l2 ~= 1 then l2 = l2 - 1 end
		end
		SMODS.calculate_context({wdylg_merge = true})
		return {xchips = LETSGO}
	 end
	 if context.post_joker then
		play_area_status_text("Dog absorbed the artifact.", true)
         card:set_ability("j_wdylg_sadnsorry")
		 return {sound = "wdylg_womp"}
	 end
	end,

	update = function (self, card)
		if math.random(1, 10000 ) == 10000  then
		play_area_status_text("Dog absorbed the artifact.", true)
         card:set_ability("j_wdylg_sadnsorry")
		 play_sound("wdylg_womp", 1)
		end
	end
}
SMODS.Joker{
	key = 'artifact',
		atlas = 'wdylhlf',
	pos = {x = 6, y = 0},
	pixel_size = {w = 71, h = 65},
	display_size = {w = 71, h = 63},
	unlocked = false,
	discovered = false,
    blueprint_compat = false,
	no_collection = true,
    rarity = 4,
	loc_vars = function(self, info_queue_center)
		return { key = G.P_CENTERS["j_wdylg_artіfact"].unlocked and "j_wdylg_artifact_revealed" or nil}
	end,
     in_pool = function(self, args)
    return not args or G.P_CENTERS["j_wdylg_artіfact"].unlocked
end,
	add_to_deck = function (self, card, from_debuff)
		if pseudorandom('wdylg_artifact', 1, 4) == 4 and (not from_debuff) then
          card:set_ability('j_wdylg_artіfact')
		  unlock_card(G.P_CENTERS["j_wdylg_artіfact"])
		end
    end,
		calculate = function (self, card, context)
	if context.before and context.cardarea == G.jokers then
		play_area_status_text("NUH UH!.", true)
		card:set_ability("j_wdylg_angry")
		return {sound = "wdylg_womp"}
	end
end
}

SMODS.Joker{
	key = 'sadnsorry',

	loc_txt = {
		name = "Empty.",
		text = {"damn.",
	            "+1 chip for pity."}
	},
	atlas = 'wdylhlf',
	pos = {x = 6, y = 0},
	pixel_size = {w = 71, h = 65},
	display_size = {w = 71, h = 63},
	unlocked = true,
	discovered = false,
    blueprint_compat = false,
	no_collection = true,
    price = 0,
in_pool = function (self, args)
      return false
	end,
	calculate = function (self, card, context)
     if context.joker_main then
		return {chips = 1, sound = "timpani"}
	 end
	end,

	add_to_deck = function(self, card, from_debuff)
		if from_debuff then return end
		card.click = function ()
			SMODS.destroy_cards(card, true, true)
		end
	end,
}


SMODS.Joker{
	key = 'WHERESTHAT',

	loc_txt = {
		name = "Chaos Emerald",
		text = {"Negates the next #1# uses of hands, resetting post-blind.",
			"1/4 chance to finally be found by shadow."}
	},
	config = {extra = {bonushands = 5, base = 5}},
    atlas = 'wdylhlf',
	pos = {x = 0, y = 0},
	pixel_size = {w = 71, h = 65},
	display_size = {w = 71, h = 95*0.5},
	loc_vars = function (self, info_queue, card)
		return{vars = {card.ability.extra.bonushands}}
	end,
	in_pool = function (self, args)
		return not (G.GAME.WDYLG ~= nil and G.GAME.WDYLG.chaosemeraldgone == true)
		end,
  set_badges = function (self, card, badges)
   badges[#badges+1] = create_badge('The Fourth One.', G.C.SUITS.Spades, G.C.SECONDARY_SET.Enhanced, 1)
  end,
  calculate = function (self, card, context)
   if context.post_play_anyeurism then
	if math.min(context.hands_due, 0.5) ~= 0.5 and card.ability.extra.bonushands > 0 then
     if card.ability.extra.bonushands + context.hands_due > 0 then
		card.ability.extra.bonushands = card.ability.extra.bonushands + context.hands_due
		return {modify = 0}
	 else
		return {message = localize('k_nope_ex') , card = card}
	 end
	end
   end
   if context.end_of_round then
	if pseudorandom("WDYLG_FOURTH", 1, 4) == 4 then
		card:set_ability("j_wdylg_sadnsorry")
		G.GAME.WDYLG.chaosemeraldgone = true
		return {message = 'Stolen...', card = card, sound = "wdylg_womp"}
	end
	if card.ability.extra.bonushands < self.config.extra.base then
		card.ability.extra.bonushands = self.config.extra.base
		return  {
					card = card,
					message = localize('k_reset')
		}
	end
   end
  end
}



SMODS.Joker{
  key = '2000',

  loc_txt = {
		name = "2000",
		text = {"Instantly scam a joker in your team for {X:chips,C:white}2000 Chips{}..."}
	},
		unlocked = true,
     discovered = false,
     blueprint_compat = true,
     eternal_compat = true,
     perishable_compat = true,
	 atlas = 'wdylj',
    rarity = 3,
	cost = 9,
	pos = {x = 2, y = 1},

calculate = function (self, card, context)
if context.joker_main then
 G.jokers.cards[pseudorandom("wdylg_2000", 1, #G.jokers.cards)]:shatter()
 return {chips = 2000}
end
end
}

SMODS.Joker{
	key = "VOID",
	loc_txt = {
		name = "The Ceaseless Void",
		text = {"I will write it soon, wait"}
	},
	config = {
		extra = {
			WAIT = 0,
			WAIT2 = 0,
			RESET = 4,
			RELEASE = false,
			ex = 12,
			somethingelse = 0,
			tempscalelordhelpme = 0,
			refreturn = function() end
		}
	},
		atlas = 'wdylhlf',
	pos = {x = 6, y = 0},
	pixel_size = {w = 71, h = 65},
	display_size = {w = 71, h = 63},
	rarity = 4,
	cost = 160,
	--[[
		in_pool = function (self, args)
      return false
	end,
]]
	WDYLG_hasability = true,
  calculate = function (self, card, context)
	if context.USEABILITY then 
		if card.ability.extra.WAIT == 0 then
		if G.booster_pack then
			card.ability.extra.WAIT = 4
			card:juice_up(0.3)
			stop_use()
			G.GAME.pack_choices = G.pack_cards
				local cons_ref, jorm = #G.consumeables, {}
				local jok_ref, jerm = #G.jokers, {}
			for i = 1, #G.pack_cards do
					if card.ability.consumeable then cons_ref = cons_ref + 1
					table.insert(jorm, i)
					else
						jok_ref = jok_ref + 1
						table.insert(jerm, i)
			end
		end
		if cons_ref > G.consumables.config.card_limit then
			for i = 1, (cons_ref - G.consumables.config.card_limit) do
				G.pack_cards[jorm[pseudorandom("WDYLG_CEASELESS", 1, #jorm)]]:set_edition("e_negative")
			end
		end
		if jok_ref > G.jokers.config.card_limit then
			for i = 1, (cons_ref - G.jokers.config.card_limit) do
				G.pack_cards[jorm[pseudorandom("WDYLG_CEASELESS", 1, #jorm)]]:set_edition("e_negative")
			end
		end
	end
	end
	if card.ability.extra.WAIT2 == 0 then
		if G.STATE == G.STATES.SELECTING_HAND then
		card.ability.extra.RELEASE = true
		card:juice_up(0.3, 0)
		card.ability.extra.WAIT2 = 4
		end
  end
  return {message = "Nothing."}
end
if context.final_scoring_step then
	for i = 1, G.play.cards do
		if SMODS.has_enhancement(G.play.cards[i], 'm_bonus') or (G.play.cards[i].edition and G.play.cards[i].edition.key == "e_foil") then
			local lifted = eval_card(G.play.cards[i], {cardarea = G.play, full_hand = G.play.cards, scoring_hand = context.scoring_hand, poker_hand = context.poker_hands})
        card.ability.extra.tempscalelordhelpme = lifted.chips * card.ability.extra.ex

		SMODS.scale_card(card, {ref_table = card.config.extra, ref_value = "somethingelse", scalar_value = "tempscalelordhelpme"})
		card.ability.extra.tempscalelordhelpme = 0
		G.play.cards[i]:shatter()
		else if G.play.cards[i].edition == nil then G.play.cards[i]:set_edition({"foil"}, true, true) end
		end
	end
end

if context.joker_main and context.repetition == false and card.ability.extra.RELEASE == true then
	card.ability.extra.RELEASE = false
	local chups_ref = card.ability.extra.somethingelse
	card.ability.extra.somethingelse = 0
	return {chips = chups_ref, sound = 'wdylg_bows'}
end
if context.blind_defeated then card.ability.extra.WAIT = math.max(card.ability.extra.WAIT - 1, 0) end
if context.after then card.ability.extra.WAIT2 = math.max(card.ability.extra.WAIT2 -1, 0) end
end,

add_to_deck = function(self, card, from_debuff)
		if from_debuff then return end
		card.ability.extra.refreturn = card.click
		card.click = function ()
			if card.ability.extra.WAIT2 == 0 or card.ability.extra.WAIT == 0 then
				card:calculate_joker({USEABILITY = true})
			end
			card.ability.extra.refreturn(card)
		end
	end,
remove_from_deck = function(self, card, from_debuff)
	if from_debuff then return end
   	local jerp = {}
	local jerp2 = {}
	for i = 1, math.floor(#G.playing_cards * 0.50) do
		local cardref = 0
		while true do
		cardref = pseudorandom("WDYLG_CEASELESS", 1, #G.playing_cards)
        if not WDYLG.find(jerp, cardref) then break end
		
  end
  table.insert(jerp, cardref)
end
for i = 1, #jerp do
	table.insert(jerp2, G.playing_cards[jerp[i]])
end
SMODS.destroy_cards(jerp2)
G.FUNCS.draw_from_deck_to_hand()
end
}

local rat_ref = {
	key = "BRM",
	loc_txt = {
	 name = "bigrat.monster",
	text = {"potential candidate for the strongest."}
	},
    config = {eternal = true},
	perishable_compat = false,
	 blueprint_compat = false,
	rarity = 4,
	cost = 0,
	atlas = 'wdylj',
    pos = {x = 6, y = 0},

	loc_vars = function(self, info_queue_center)
		return { key = next(SMODS.find_mod("JoyousSpring")) ~= nil and "j_wdylg_BRM_crossmod" or nil}
	end,
	calculate = function (self, card, context)
        if context.before then
			local potatochips = 0 
			local conversionrate = 0
			for i = 1, #G.play.cards do
				local otherret = eval_card(G.play.cards[i], {cardarea = G.play, full_hand = G.play.cards, scoring_hand = context.scoring_hand, poker_hand = context.scoring_name})
             if SMODS.has_enhancement(G.play.cards[i], "m_stone") then potatochips = (potatochips + otherret.chips) or 0
				G.play.cards[i]:set_edition(nil, true)
				G.play.cards[i].seal = nil
				G.play.cards[i]:set_ability(G.P_CENTERS.c_base, nil, true)
				card:juice_up(0.3, 0)
				G.play.cards[i]:juice_up()
				G.play.cards[i].vampired = true
				G.play.cards[i]:set_debuff(true)
				conversionrate = conversionrate + 1
			 end
		end
		if conversionrate >= 5 or context.scoring_name == "Bulwark" then
			if pseudorandom("WDYLG_brminstakill") <= 0.10 then
				G.GAME.blind.chips = 0
                G.GAME.blind.chip_text = "OBLITERATED." --number_format(G.GAME.blind.chips)
                G.GAME.chips = G.GAME.chips + 5
                SMODS.juice_up_blind()
				G:update_new_round()
				love.system.openURL("https://bigrat.monster/") --will change this to the image directly if anything happens.
				--love.system.openURL("https://raw.githubusercontent.com/bigratmonster/bigrat.monster/refs/heads/main/media/bigrat_full.jpg")
			end
		end
		local other_joker = G.jokers.cards[#G.jokers.cards]
		if other_joker == card then other_joker = G.play.cards[#G.play.cards] end
		if potatochips == 0 then return end
		other_joker.ability.perma_bonus = potatochips
		other_joker.ability.perma_repetitions = math.floor(potatochips / 5)
	end
end
}

if next(SMODS.find_mod("JoyousSpring")) then
	rat_ref.config.extra = {}
	rat_ref.config.extra.JoyousSpring = JoyousSpring.init_joy_table {
		attribute = "EARTH",
		monster_type = "BEAST",
		summon_type = "NORMAL",
		monster_archetypes = { ["Danger"] = true }
	}
	rat_ref.joy_desc_cards = {
		{ properties = { { monster_archetypes = { "Danger" } } }, name = "k_joy_archetype" }, --this specific line was snatched from line 49 in JoyousSpring's 21danger.lua.
}
end
SMODS.Joker(rat_ref)

SMODS.Joker{
	key = "trangle",
	loc_txt = {
    name = "Triangle.",
	text = {"IS THAT THE EVIL TRIANGLE",
            'THAT STARS IN THE LEVEL "BARRACUDA"',
		     "FROM HIT GAME JUST SHAPES AND BEATS?!"},
},
config = {extra = {tempreturns = 0, tempplayed = 0}},
rarity = 4,
cost = 30,
atlas = "wdylj",
pos = {x = 6, y = 0},
perishable_compat = true,
blueprint_compat = false,


calculate = function(self, card, context)
	if context.before then
			card.ability.extra.tempplayed = #context.full_hand
	for i = 1, #context.full_hand do
		if not WDYLG.find(context.scoring_hand, context.full_hand[i]) and context.full_hand[i].ability.wdylg_TOKEN ~= true then
			card.ability.extra.tempreturns = card.ability.extra.tempreturns + (context.full_hand[i].base.nominal + context.full_hand[i].ability.bonus + (context.full_hand[i].ability.perma_bonus or 0))
		end
	end
	print("now serving ".. card.ability.extra.tempplayed.. " and ".. card.ability.extra.tempreturns) 
	end
  if context.modify_scoring_hand then
	return {
		add_to_hand = true
	}
  end
if context.joker_main then
if card.ability.extra.tempreturns == 0 then return end
  local endresult = round_number(((math.sqrt(3))/4*round_number(card.ability.extra.tempreturns, 0)^2) / 100, 1)
  for i = 1, #G.hand.cards do
	G.hand.cards[i].ability.perma_x_mult = G.hand.cards[i].ability.perma_x_mult + endresult
  end
  card.ability.extra.tempreturns = 0
  return {
	extra = {message = "T R I A N G U L A T E D", colour = G.C.MULT},
	card = card
  }
end
if context.after then
				if card.ability.extra.tempplayed < G.hand.config.highlighted_limit then
			for i = 1, G.hand.config.highlighted_limit - card.ability.extra.tempplayed do
			local snake = SMODS.create_card{set = 'Playing Card', skip_materialize = true, rank = '3', suit = 'Hearts', edition = "e_negative"}
			snake:add_sticker("wdylg_TOKEN", true)
			snake:add_to_deck()
			G.hand:emplace(snake)
            snake.ability.forced_selection = true
			G.hand:add_to_highlighted(snake, true)
			end
			card.ability.extra.tempplayed = 0
		end
end
end
}

SMODS.Joker{
	key = 'grave',
	loc_txt = {
      name = "Volatile Grave",
	  text = {"Trying to play a hand already in most played",
			 "Has 1:I odds of killing you Instantly, where",
			 "I is the number of most played hands.",
			 "Otherwise, {X:mult,C:White}x#2#{} Mult added to your pre-existing {X:mult,C:White}x#1#{}"}
	},
	pos = {x=9,y=12},
	rarity = 3,
	config = {Xmult = 1, extra = 0.25},
	discovered =false,

	in_pool = function (self, args)
      return false
	end,
    cost = 0,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, center)
      return {vars = {center.ability.Xmult, center.ability.extra}}
	end,

	calculate = function (self, card, context)
       if context.before then
		local callpity = true
		local reset = false
		local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
		for c, v in pairs(G.GAME.hands) do
			if c ~= context.scoring_name and v.played >= play_more_than and v.visible then
				callpity = false
				break
			end
		end
		if callpity then
			local ofthedraw = {}
			play_more_than = play_more_than - 1
			reset = true
			for c, v in pairs (G.GAME.hands) do
				if v.played == play_more_than then table.insert(ofthedraw, c) end
			end
			pseudoshuffle(ofthedraw, "WDYLG_obelpity")
			if not context.scoring_name == ofthedraw[1] then
				reset = false
			end
			if reset == true then
			G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false
		end
		end
		SMODS.scale_card(card, {ref_table = card.ability, ref_value = "Xmult", scalar_value = "extra"})
	end
end
}

SMODS.Joker{
	key = "ORANGEFM",
	loc_txt = {
		name = "Orange Frontman.",
		text = {"Increases played diamonds' base chips by {X:chips, C:white}#1#%{}",
	            "PURPOSELY ignores enhancements."},
		unlock = {"Jimbo, how tf do i",
		          "craft orange Frontman in balatro?"}
	},
	in_pool = function (self, args)
      return self.unlocked
	end,
	loc_vars = function (self, args, card)
		return {vars = {(card.ability.extra - 1 * 10) * -1}}
	end,
    cost = 40,
	rarity = 4,
	discovered = false,
	unlocked = false,
	atlas = 'wdylj',
	pos = {x = 6, y = 0},
    config = {extra = 1.15},
	calculate = function(self, card, context)
		if context.initial_scoring_step then
			local returnnow = false
			for i = 1, #context.full_hand do
				if context.full_hand[i].base.suit_nominal == 0.01 then
				context.full_hand[i].ability.bonus = context.full_hand[i].ability.bonus + round_number((context.full_hand[i].base.nominal ^ card.ability.extra), 1)
				context.full_hand[i]:juice_up()
				returnnow = true
				end
			end
			if returnnow then return {message = "^".. card.ability.extra.. " Chips"} end
		end
		if context.joker_main then
			if card.ability.extra ~= self.config.extra then
				card.ability.extra = self.config.extra
				return {
					message = localize('k_reset')
				}
			end
		end
	end
}

SMODS.Joker{
	key = "diamond",
	loc_txt = {
		name = "Avaricial Diamond",
		text = {"Each diamond scored gives its nominal as money."}
	},
	in_pool = function (self, args)
      return false
	end,
	cost = 40,
	rarity = 4,
	discovered = false,
	unlocked = false,
	atlas = 'wdylj',
	pos = {x = 6, y = 0},

	calculate = function(self, card, context)
       if context.individual and context.cardarea == G.play then
		if context.other_card:is_suit('Diamonds') then
		return {dollars = context.other_card.base.nominal}
		end
	   end
	end
}

