SMODS.Consumable{
    key = 'sewing',
    set = 'Spectral',
    loc_txt = {
        name = "Sewing Needles",
        text = {"{C:inactive}AAA DON'T TURN ME INTO A MARKETABLE PLUSHIE!{}",
                "Using this will instakill the blind at less than 20%",
                 "of chips remaining. Netting you a cute plushie."}
    },
    config = {},
    		atlas = 'wdylj',
	pos = {x = 6, y = 0},
    cost = 10,
    select_card = 'consumables',

    can_use = function (self, card)
        return not G.game.blind == nil
    end,

    use = function (self, card, area, copier)
       if G.GAME.chips/G.GAME.blind.chips > 0.80 then
        G.GAME.blind.chips = 0
        G.GAME.blind.dollars = 0
        G.GAME.blind.chip_text = "Poofed." --number_format(G.GAME.blind.chips)
        G.GAME.chips = G.GAME.chips + 180
        local jimmy =    SMODS.add_card{key = "j_wdylg_plushie"}
        jimmy.extra.ID = G.GAME.blind.key
        jimmy.extra.origin = "BLIND"
        return {message = "Success.", card = jimmy}
       else
        SMODS.juice_up_blind()
        return {message = "Missed.", card = card}
       end
    end
}

--paperback thanky ou
SMODS.Consumable{
    key = 'spraydestroyah',
    set = 'Spectral',
    loc_txt = {
        name = 'Graphice',
        text = {'Gives a selected joker x13 chips.'}
    },
    config = { extra = {skiddedagain = 1}},
    atlas = 'wdylc',
pos = {x = 0, y = 0},
soul_pos = {x = 0, y = 1},
    cost = 45,

can_use = function (self, card)
        return #G.jokers.highlighted == card.ability.extra.skiddedagain
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
        name = 'Stick',
        text = {"50% chance to get rid of ",
                 "selected joker."}
    },
    config = { extra = {skiddedagain = 1}},
    	atlas = 'wdylj',
	pos = {x = 6, y = 0},
    cost = 7,
    set_badges = function (self, card, badges)
   badges[#badges+1] = create_badge('-XIII', G.C.SUITS.Hearts, G.C.UI.TEXT_INACTIVE, 1)
  end,
    can_use = function (self, card)
        return #G.jokers.highlighted == card.ability.extra.skiddedagain
 end,
 use = function (self, card, area, copier)
    if math.min(1, math.random(1, 2)) ~= 1 then
            local wevreakafterthis = G.jokers.highlighted[1]
            wevreakafterthis:set_ability("j_wdylg_sadnsorry")
            SMODS.destroy_cards(wevreakafterthis, true)
    end
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
