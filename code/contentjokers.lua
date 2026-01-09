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
    if round_number(current_hand_mult * scmult, 1) > cfp then
	local lsh = G.GAME.chips - (G.GAME.chips * round_number(current_hand_mult * scmult, 1))
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
if context.end_of_round and (not context.game_over) and #G.consumeables.cards < G.consumeables.config.card_limit then
G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
SMODS.add_card{key = "c_judgement"}
G.GAME.consumeable_buffer = 0
juice_card(card)
return {message = "W CARDS?", card = card}
end

if context.using_consumeable and context.card_added and context.cardarea == G.jokers and context.consumable.key == "Judgement" then
juice_card(card)
if context.card.rarity < 3 then return {message = "L cards...", card = card} else return {message = "W CARDS!", card = card} end
end
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
pos = {x = 6, y = 0},

check_for_unlock = function (self, args)
	
	if G.P_CENTERS["j_perkeo"].unlocked then
		unlock_card(self)
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
 if contexttext > 0 then return {message = "*Borrowed "..contexttext.."cards*"} end
 contexttext = 0
 end

if context.blind_defeated then
    for i, v in ipairs(card.ability.extra.borrowed) do
		SMODS.create_card{key = v, edition = 'e_negative'}
		contexttext = contexttext + 1
	end
	if contexttext > 0 then return {message = "*Returned "..contexttext.."cards*"} end
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
        "#1# in #2# chance for #3# mult, {C:attention}ALTHOUGH{}..."}
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

	card.ability.extra.jumpmult = card.ability.extra.jumpmult + (1 + WDYLG.valfunc("^", 2, card.ability.extra.uhh))
else
	WDYLG.ability.WAAAAAARGH(card)
	return {mult = card.config.extra.jumpmult, sound = 'wdylg_wega'}
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
			LETSGO = LETSGO + tonumber(WDYLG.valfunc("^", l1, l2))
			if l2 ~= 1 then l2 = l2 - 1 end
		end
		return {mult = (G.GAME.chips * LETSGO) - G.GAME.chips}
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
	no_collection = true,
	unlocked = true,
	discovered = false,
    blueprint_compat = false,
    price = 0,
in_pool = function (self, args)
      return false
	end,
	calculate = function (self, card, context)
     if context.joker_main then
		return {chips = 1, sound = "timpani"}
	 end
	end
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
     if card.ability.extra.bonushands + context.hands_due > 0 and math.min(context.hands_due, -1) ~= -1 then
		card.ability.extra.bonushands = card.ability.extra.bonushands + context.hands_due
		return {modify = context.hands_due * -1}
	 end
    if context.hands_due == -1 then
		card.ability.extra.bonushands = card.ability.extra.bonushands - 1
		return {modify = context.hands_due * -1}
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
	end
   end
  end
}

SMODS.Joker{
	key = 'dunnohaventplayedcrkbefore',

	loc_txt = {
		name = "Black Sapphire",
		text = {"UHMM i have no clue.",
	            "{C:attention}currently targeting #1#{}"}
	},
	config = {extra = {target = nil}},
	unlocked = true,
     discovered = false,
     blueprint_compat = false,
     eternal_compat = true,
     perishable_compat = true,
    rarity = 4,
	cost = 50,
    pos = {x = 6, y = 0},
    wdylg_imitates = {"j_yahimod_yahicard"},

	loc_vars = function(self,info_queue,card)
    return {vars = {card.ability.extra.target ~= nil and card.ability.extra.target.name or "No One"}}
	end,
	calculate = function (self, card, context)
       if context.setting_blind then
		card.ability.extra.target = G.jokers.cards[pseudorandom("WDYLG_yahiamouse", 1, #G.jokers)]
		end
		if context.before and context.cardarea == G.hand then
			local playsound = false
			for i = 1, #G.hand.cards do
				if G.hand.cards[i].base.nominal == 2 then
               local playsound = true
		G.E_Manager:add_event(Event({
        trigger ='immediate',
		blocking = false,
		blockable = false,
		func = function ()
			draw_card(G.hand, G.discard, nil, nil, G.hand.cards[i])
		return true
		end
	}))
				end
			end
							if next(SMODS.find_card('j_wee', true)) ~= nil then
				draw_card(G.hand, G.discard, nil, nil, next(SMODS.find_card('j_wee', true)))
				next(SMODS.find_card('j_wee', true)):set_debuff(true)
				playsound = true
				end
				if playsound == true then return {sound = 'WDYLG_tewcone'} end
		end
		if context.post_trigger then
			if card.ability.extra.target ~= context.other_card then return end
			local other_ret = context.other_ret.jokers or {}
			for i = 1, other_ret do
				if type(other_ret[i]) == "number" then
					other_ret[i] = other_ret[i] * 0.74
				end
			end
			card:juice_Up()
		end
	   end
}

SMODS.Joker{
  key = '2000',

  loc_txt = {
		name = "2000",
		text = {"Instantly scam a joker in your team for 2000 chips..."}
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
	key = 'marketable',

	loc_txt = {
		name = "Plushie",
		text = {"{C:inactive,S:0.9}Aww so cu- wait how did you get this?{}",
	            "This plushie of #1# will be sure to keep you companion till the end...",
                "{C:inactive,S:0.75,E:2}Or at least till you sell it for double usual earnings.{}"}
	},
	config = { extra = {ID = nil, origin = nil} },
		atlas = 'wdylhlf',
	pos = {x = 6, y = 0},
	pixel_size = {w = 71, h = 65},
	display_size = {w = 71, h = 63},
	rarity = 1,
	in_pool = function (self, args)
      return false
	end,
    cost = 0,
	loc_vars = function(self,info_queue,card)
	if card.ability.extra.origin == nil then return{vars = {"Nothing."}} end 

	if card.ability.extra.origin == "BLIND" then
        return{vars = {G.P_BLINDS[card.ability.extra.ID].name}}
	elseif card.ability.extra.origin == "JOKER" then
		return{vars = {G.P_CENTERS[card.ability.extra.ID].name}}
	end
	end,
	calculate = function (self, card, context)
		if context.card == card then return {sound = "wdylg_squeak"} end

		if card.ability.extra.ID == nil and card.ability.extra.origin == nil then return end
      if card.ability.extra.origin == "BLIND" then
		card.cost = G.P_BLINDS[card.ability.extra.ID].dollars * 2
	  elseif card.ability.extra.origin == "JOKER" then
        card.cost = G.P_CENTERS[card.ability.extra.ID].cost * 2
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
			tempscalelordhelpme = 0
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
	else
		return {message = "Nothing."}
	end
	if G.STATE == G.STATES.SELECTING_HAND then
		card.ability.extra.RELEASE = true
		card:juice_up(0.3, 0)
		card.ability.extra.WAIT2 = 4
	end
  end
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

if context.before and context.repetition == false and card.ability.extra.RELEASE == true then
	card.ability.extra.RELEASE = false
	local chups_ref = card.ability.extra.somethingelse
	card.ability.extra.somethingelse = 0
	return {chips = chups_ref, sound = 'wdylg_bows'}
end
if context.blind_defeated then card.ability.extra.WAIT = math.max(card.ability.extra.WAIT - 1, 0) end
if context.after then card.ability.extra.WAIT2 = math.max(card.ability.extra.WAIT2 -1, 0) end
end,

remove_from_deck = function(self, card, from_debuff)
	if from_debuff then return end
   	local jerp = {}
	for i = 1, math.floor(#G.deck.cards * 0.50) do
		local cardref = 0
		while true do
		cardref = pseudorandom("WDYLG_CEASELESS", 1, #G.playing_cards)
        if not WDYLG.find(jerp, cardref) then break end
		
  end
  table.insert(jerp, cardref)
end
for i = 1, #jerp do
	table.insert(jerp, jerp[i], G.playing_cards[i])
end
SMODS.destroy_cards(jerp)
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