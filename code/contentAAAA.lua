

--paperback thanky ou
SMODS.Consumable{
    key = 'spraydestroyah',
    set = 'Spectral',
    loc_txt = {
        name = 'Graphice',
        text = {'Gives a selected joker x13 chips.'}
    },
    config = { extra = 1},
    atlas = 'wdylc',
pos = {x = 0, y = 0},
soul_pos = {x = 0, y = 1},
    cost = 45,

can_use = function (self, card)
        return #G.jokers.highlighted == card.ability.extra
 end,

 use = function (self, card, area, copier)
    local wevreakafterthis = G.jokers.highlighted[1]
    wevreakafterthis.ability.extra.perma_x_chips = wevreakafterthis.ability.perma_x_chips or 0
    wevreakafterthis.ability.extra.perma_x_chips = 13
 end
}

SMODS.Consumable {
    key = 'mindcontrol',
    set = 'Tarot',
    loc_txt = {
        name = 'The Stick',
        text = {"50% chance to get rid of ",
                 "selected joker."}
    },
    config = { extra = 1},
    	atlas = 'wdylj',
	pos = {x = 6, y = 0},
    cost = 7,
    set_badges = function (self, card, badges)
   badges[#badges+1] = create_badge('-XIII', G.C.SUITS.Hearts, G.C.UI.TEXT_INACTIVE, 1)
  end,
    can_use = function (self, card)
        return #G.jokers.highlighted == card.ability.extra
 end,
 use = function (self, card, area, copier)
    if math.min(1, math.random(1, 2)) ~= 1 then
            local wevreakafterthis = G.jokers.highlighted[1]
            wevreakafterthis:set_ability("j_wdylg_sadnsorry")
            SMODS.destroy_cards(wevreakafterthis, true)
    end
 end
}

SMODS.Consumable {
    key = 'MGSV',
    set = 'Tarot',
    loc_txt = {
        name = 'The Man Who Sold The World',
        text = {"Sets Full house to level 0 and..."}
    },
        	atlas = 'wdylj',
	pos = {x = 6, y = 0},
    cost = 9,
    soul_set = "Planet",
    soul_rate = 0.055,
    can_repeat_soul = true,
        set_badges = function (self, card, badges)
   badges[#badges+1] = create_badge('-XXI', G.C.SUITS.Hearts, G.C.UI.TEXT_INACTIVE, 1)
  end,
  can_use = function (self, card)
     return G.GAME.hands["Full House"].level > 0
  end,
 use = function (self, card, area, copier)
    ease_dollars(G.P_CENTER_POOLS.Planet["c_earth"].cost * G.GAME.hands["Full House"].level)
    SMODS.smart_level_up_hand(card, 'Full House', true, G.GAME.hands["Full House"].level * -1)
 end
}

SMODS.Consumable {
    key = 'MGSVTAINTED',
    set = 'Spectral',
    loc_txt = {
        name = 'NighMortem Neutron Star',
        text = {"Don't let this near any friend with a common allergy.",
                "Idea by jndydotjpeg.",
            "{X:inactive,C:default,s:0.90}Currently Targeting: #1#{}"}
    },
    hidden = true,
    soul_set = "Planet",
    soul_rate = 0.010,
    can_repeat_soul = true,

        	atlas = 'wdylj',
	pos = {x = 6, y = 0},
    cost = 100,
    config = {extra = {poker_hand = 'High Card'}},
        set_badges = function (self, card, badges)
   badges[#badges+1] = create_badge('-XXI?', G.C.SUITS.Hearts, G.C.UI.TEXT_INACTIVE, 1)
  end,
  
  set_ability = function(self, card, initial, delay_sprites)
    if not initial then return end
    card.config.extra.poker_hand = G.handlist[pseudorandom("WDYLG_keptyouwaiting", 1, #G.handlist)]
  end,
   loc_vars = function (self, info_queue, card)
    --thanks vanillaremade
      local Planet
     for _, center in pairs(G.P_CENTER_POOLS.Planet) do
        if center.config.hand_type == card.config.extra.poker_hand then
        Planet = center.name
    end
     end
     if Planet == nil then Planet = "The World" end
     return {vars = {Planet}}
   end,
  use = function (self, card, area, copier)
    local finallevel = 0
    local todestroy = {}
    for i = 1, G.handlist do
        if G.GAME.hands[G.handlist[i]].level > 0 and G.handlist[i] ~= card.config.extra.poker_hand then
            finallevel = finallevel + G.GAME.hands[G.handlist[i]].level
             SMODS.smart_level_up_hand(card, G.handlist[i], true, G.GAME.hands[G.handlist[i]].level * -1)
        end
    end
    for i = 1, G.playing_cards do
        if next(SMODS.get_enhancements(G.playing_cards[i])) == nil then
            table.insert{todestroy, G.playing_cards[i]}
            finallevel = finallevel + G.playing_cards[i].base.nominal
        end
    end
    for i = 1, G.jokers.cards do
        table.insert{todestroy, G.jokers.cards[i]}
        finallevel = finallevel + G.jokers.cards[i].sell_cost
    end
    SMODS.destroy_cards(todestroy, false, true)
    SMODS.smart_level_up_hand(card, card.config.extra.poker_hand, true, math.floor(finallevel / 2))
 end
}

SMODS.Consumable {
    key = 'theonlydirecttboireferenceinthemodtrust',
    set = 'Spectral',
    loc_txt = {
        name = 'Moving Box',
        text = {"Certain jokers get sent to the vouchers area"}
    },
    config = {extra = 1},
    atlas = 'wdylj',
	pos = {x = 6, y = 0},
    cost = 6,
    select_card = 'consumeables',
can_use = function (self, card)
        return #G.jokers.highlighted == card.ability.extra and WDYLG.find(WDYLG.static.embeddable, G.jokers.highlighted[1].config.center_key)
 end,

  use = function (self, card, area, copier)
    card:juice_up()
    draw_card(G.jokers.highlighted, G.vouchers)
    card:flip()
  end
}

SMODS.Voucher {
key = 'rsafail',
name = 'Overwhelming Purity',
unlocked = false, 
discovered = false,
no_collection = true,
cost = 0,
	atlas = 'wdylj',
	pos = {x = 6, y = 0},
	pixel_size = { w = 71, h = 95 },
in_pool = function (self, args)
    return false
end,

calculate = function(self, card, context)
if context.card_added then
if context.card.config.center.original_mod ~= nil and ( card.key ~= "v_wdylg_rsatemp" and card.key ~= "v_wdylg_rsafail") then 
card:set_debuff(true)
end
end

if context.first_hand_drawn then
for i, v in pairs(G.deck.cards) do
if v.edition and not WDYLG.unfortunantlyihadtoskidthistime(self.effect.extra.whitelist, v.edition.key) then
v:set_debuff(true)
end
end

end
end
}

SMODS.Voucher{
    key = 'open_archive',
	loc_txt = {
	name = "Open as Archive",
	text = {"When selling a joker:",
	       "Generate non-jokers according to sell value."}
	},
 unlocked = true,
 discovered = false,
	cost = 10,
	atlas = 'wdylj',
	pos = {x = 0, y = 0},
	pixel_size = { w = 71, h = 95 },
	calculate = function (self, card, context)
	if context.selling_card and context.card.ability.set == "Joker" and not context.selling_self then 	local val = context.card.sell_cost
	local temp = round_number(val / 2, 1)
	if temp >= 1 or val <= 3 then
        if val <= 3 then temp = val end 
	for i=1, temp+1 do
		    juice_card(card)
	local temp2 = pseudorandom("wdylg_oa", 0, 1)
	 if temp2 == 0 or #G.consumeables.cards >= G.consumeables.config.card_limit then
	SMODS.add_card{set = "Playing Card"}
	 elseif temp2 == 1 and #G.consumeables.cards < G.consumeables.config.card_limit then
	 G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
	 SMODS.add_card{ set = "Tarot" }
	  end
	  G.GAME.consumeable_buffer = 0
	  if (not G.booster_pack) and G.STATE ~= G.STATES.SELECTING_HAND then G.FUNCS.draw_from_hand_to_deck() end
  end
  return {message = "Extracted", card = context.card}
  else
  return {message = "Not a valid Archive", card = context.card}
 end
end
end
}
