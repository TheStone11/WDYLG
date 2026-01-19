WDYLG.static.embeddable = {
    "j_four_fingers",
    "j_credit_card",
    "j_chaos",
    "j_space",
    "j_superposition",
    "j_seance",
    "j_shortcut",
    'j_to_the_moon',
    'j_hallucination',
    'j_juggler',
    'j_drunkard',
    'j_satellite',
    'j_burnt',
    'j_chicot',
    'j_wdylg_oldman',
    'j_wdylg_NOTTHEONEFROMFORSAKEN',
    'j_entr_tesseract'
}

WDYLG.static.pregametitles = {
    "Why Do YOU Like General?",
    "Big Rat Monster strikes again.",
    "The owner of WDYLG thanks Lapsem for letting him use their background recoloring function.",
    "Also try ########",
    "DELTARUNE TOMORROW!!!",
    "The Raccoon broke my garbage again.",
    "TV TROPES DOES NOT LIKE THIS.",
    "+4 Mult",
    ".--- --- -.- . .-.",
    "0110101001101111011010110110010101110010",
    "10 15 11 05 19",
    "I ran out of ideas.",
    "Working on identifiying all astros.",
    "Gangster Edition",
    "valfunc has been deprecated",
    "Jimbo's Mod",
    "FLEENTSTONES???",
    "He was caught powerscaling jokers",
    "Not your average children's card game.",
    "SHOCKING: MAN GETS JUMPED BY 500 PATCH ERRORS.",
    "George08091, this wouldnt be possible without you making that gif.",
    "Did i scare you?",
    "why do you like #genaral?"
}

SMODS.current_mod.reset_game_globals = function (run_start)
 if love.window.getTitle( ) ~= "Balatro" then love.window.setTitle("Balatro") end
if run_start then G.GAME.WDYLG = {} 
G.GAME.WDYLG.hiddenhands = {"cry_None"}
 for i, _ in pairs(G.GAME.hands) do if SMODS.is_poker_hand_visible(i) == false and not WDYLG.find(G.GAME.WDYLG.hiddenhands, i) == false then table.insert(G.GAME.WDYLG.hiddenhands, i) end end
G.GAME.WDYLG.chaosemeraldgone = false
check_for_unlock({type = 'wdylg_also_unlock'})
G.GAME.WDYLG.catblacklist = copy_table(WDYLG.catblacklistspecific)
for i, v in ipairs(G.P_CENTERS) do
  if v.config.slugcat == true then
    table.insert(G.GAME.WDYLG.catblacklist, i)
  end
end
G.GAME.WDYLG.blindcount = {}
for i, _ in pairs(G.P_BLINDS) do
      if G.GAME.WDYLG.blindcount[i] == nil then  G.GAME.WDYLG.blindcount[i] = 0 end
     end
end
end

SMODS.current_mod.calculate = function(self, context)
     if context.blind_defeated then
    G.GAME.WDYLG.blindcount[G.GAME.blind.config.blind.key] = G.GAME.WDYLG.blindcount[G.GAME.blind.config.blind.key] + 1
  end
  if context.mod_probability then
    if context.identifier == "Banana Sticker" and context.trigger_obj.config.WDYLG_harsh == true then
      return {numerator = 3}
    end
  end
end