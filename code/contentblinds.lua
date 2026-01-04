


SMODS.Blind {
key = 'rasa',
-- all modded jokers are disabled, this becomes permanent if blind gets oneshot, if hand contains more than 3 modded material at time of play, forfiet the game.
name = 'Undone',
vars  = {},
boss = {min = 7, max = 10},
mult = 0.5,
dollars = 10,
effect = {whitelist = {"e_foil", "e_holo", "e_polychrome" }, cardstilldeath = 0},

set_blind = function(self)
for i, v in ipairs(G.jokers.cards) do
local card = v
if card.config.center.original_mod ~= nil and (card.key ~= "v_wdylg_rsafail") then 
card:set_debuff(true)
self:wiggle()
end
end

--thanks to  somehtingcom515 for teaching me this
end,

press_play = function(self) 
local ctd = G.GAME.blind.effect.cardstilldeath
for i, v in pairs(G.hand.cards) do
if v.edition and not WDYLG.find(self.effect.whitelist, v.edition.key) then
ctd = ctd + 1
end
end
if ctd >= 3 then G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false end
end, 
disable = function(self)
for i, v in pairs(G.jokers.cards) do
v:set_debuff(false)
end
end,

calculate = function (self, blind, context)
    if context.after and SMODS.last_hand_oneshot then
Card.apply_to_run(G.P_CENTERS.v_wdylg_rsafail)
end
end

}

SMODS.Blind {
 key = "supreme_wall",
 loc_txt = {
name = 'Defenestration Prime',
text = {"Check Pins",
        'For Complete Explaination.'}
 },
 effect = {initialmult = 4, anchor = 0}, 
mult = 4,
boss_colour = HEX('84b7b6'),

set_blind = function (self)

local anchortemp = 0
    for i, _ in pairs(G.P_BLINDS) do
        anchortemp = (anchortemp + math.max(1, G.P_BLINDS[i].mult)) or anchortemp + 1
    end
    G.GAME.blind.effect.anchor = anchortemp
self.mult = WDYLG.valfunc("^", G.GAME.blind.effect.initialmult, G.GAME.blind.effect.anchor)
self.chips = get_blind_amount(G.GAME.round_resets.ante)*self.mult*G.GAME.starting_params.ante_scaling
self.chip_text = number_format(G.GAME.blind.chips)
self:wiggle()

--shamelessly taken from vanillaremade.
 if not self.disabled then
                G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
                ease_hands_played(-G.GAME.blind.hands_sub)
            end
end,

disable = function (self)
ease_hands_played(G.GAME.blind.hands_sub)
play_area_status_text("CAN'T STOP THE WALL!")
end,

press_play = function (self)
 G.ROOM.jiggle = G.ROOM.jiggle + 10
 local rubble = {}
 for i = 1, #G.discard.cards do
         if SMODS and SMODS.has_enhancement(G.discard.cards[i], "m_glass") or G.discard.cards[i].config.center.key == "m_glass" then
         local j = G.discard.cards[i].base.nominal
         for e = 1, #G.deck.cards do
         if (SMODS and SMODS.has_enhancement(G.deck.cards[e], "m_glass") or G.deck.cards[e].config.center.key == "m_glass") and G.deck.cards[e].base.nominal == j and pseudorandom('glass') < G.GAME.probabilities.normal/G.deck.cards[e].ability.extra then
         table.insert(rubble, G.deck.cards[e])
         G.deck.cards[e]:shatter()
         end
         if pseudorandom('glass') < G.GAME.probabilities.normal/G.discard.cards[e].ability.extra then G.discard.cards[e]:shatter() end
         end
        end
    for j = 1, #G.jokers.cards do
     eval_card(G.jokers.cards[j], {cardarea = G.jokers, remove_playing_cards = true, removed = rubble})
    end
end
end,

calculate = function (self, blind, context)
    if context.pre_discard and not blind.disabled then
        for i = 1, context.full_hand do
            blind.effect.initialmult = blind.effect.initialmult * context.full_hand[i].base.nominal
        end
       self.mult = WDYLG.valfunc("^", G.GAME.blind.effect.initialmult, G.GAME.blind.effect.anchor)
        self.chips = get_blind_amount(G.GAME.round_resets.ante)*self.mult*G.GAME.starting_params.ante_scaling
        self.chip_text = number_format(G.GAME.blind.chips)
         G.E_MANAGER:add_event(Event({ func = function()
         for i = 1, #G.discard.cards do
         if SMODS.has_enhancement(G.discard.cards[i], "m_glass") then
            local v = G.discard.cards[i].base.nominal
            for c = 1, #G.hand.cards do
            if G.hand.cards[c].base.nominal == v and pseudorandom("WDYLG_defenes2", G.GAME.probabilities.normal, 3) < 3 then
            G.hand.cards[c]:set_ability(G.P_CENTERS.m_glass)
            end
            end
         else
          if pseudorandom("bl_defenes", G.GAME.probabilities.normal, 5) ~= 5 then
           G.Discard.Cards[i]:set_ability(G.P_CENTERS.m_glass)
            G.Discard.Cards[i]:juice_up()
           end 
           end
           end
        return true end })) 
        self.triggered = true
        delay(0.7)
        blind:wiggle()
    end
end

}

SMODS.Blind {
    key = "TOKJ",
    loc_txt = {
        name = "Killjoy",
        text = {"Only hidden hands allowed,",
                "Modded rarities are REROLLED."}
    },
    effect = {whitelist = {}},
    set_blind = function(self)
        for i, _ in G.P_JOKER_RARITY_POOLS do
            if type(tonumber(i)) == "number" then table.insert(G.GAME.blind.effect.whitelist, i) end
        end
        for i = 1, G.jokers.cards do
            if type(tonumber(G.P_CENTERS[G.jokers.cards[i].config.center_key].rarity)) ~= "number" or (next(SMODS.find_mod("busterb")) and G.jokers.cards[i].config.center_key == 'j_wdylg_phrime') then
                local temp = G.P_JOKER_RARITY_POOLS[G.GAME.blind.effect.whitelist[pseudorandom("WDYLG_TOKJ", 0, #G.GAME.blind.effect.whitelist)]]
                G.jokers.cards[i]:set_ability(temp[pseudorandom("WDYLG_TOKJ2", 0, #temp)])
            end
        end
    end,

    debuff_hand = function(self, cards, hand, handname, check)
        if handname == "cry_None" then
            --for all the cryptid players out there...
            G.GAME.blind:wiggle() 
            G.STATE = G.STATES.GAME_OVER
            G.STATE_COMPLETE = false
        end
       if not WDYLG.find(G.GAME.hiddenhands, handname) then
        G.GAME.blind:wiggle() 
        return true 
        end
    end
}


