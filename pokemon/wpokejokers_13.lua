-- Snorunt 361
local snorunt={
  name = "snorunt",
  pos = {x = 2, y = 11},
  config = {extra = {debt = 15,rounds = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.debt, center.ability.extra.rounds}}
  end,
  rarity = 1,
  cost = 4,
  item_req = "dawnstone",
  stage = "Basic",
  ptype = "Water",
  atlas = "Pokedex3",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    local evolve = item_evo(self, card, context, "j_poke_froslass")
    if evolve then
      return evolve
    else
      local in_debt = nil
      if (SMODS.Mods["Talisman"] or {}).can_load then
        in_debt = to_big(G.GAME.dollars) < to_big(0)
      else
        in_debt = G.GAME.dollars < 0
      end
      if in_debt then
        return level_evo(self, card, context, "j_poke_glalie")
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra.debt
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not from_debuff then
      G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra.debt
    end
  end,
}
-- Glalie 362
local glalie={
  name = "glalie",
  pos = {x = 3, y = 11},
  config = {extra = {debt = 20}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.debt}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Water",
  atlas = "Pokedex3",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card:juice_up()
      local back_to_zero = 0
      if (SMODS.Mods["Talisman"] or {}).can_load then
        back_to_zero = to_number(-G.GAME.dollars)
      else
        back_to_zero = -G.GAME.dollars
      end
      ease_dollars(back_to_zero, true)
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra.debt
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra.debt
  end,
}
-- Spheal 363
-- Sealeo 364
-- Walrein 365
-- Clamperl 366
-- Huntail 367
-- Gorebyss 368
-- Relicanth 369
-- Luvdisc 370
-- Bagon 371
-- Shelgon 372
-- Salamence 373
-- Beldum 374
local beldum={
  name = "beldum", 
  pos = {x = 5, y = 12},
  config = {extra = {chips = 0, chip_mod = 8, size = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.chips, center.ability.extra.chip_mod, center.ability.extra.size}}
  end,
  rarity = 2, 
  cost = 6, 
  stage = "Basic", 
  ptype = "Metal",
  atlas = "Pokedex3",
  perishable_compat = false,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.before and not context.blueprint then
        local has_ace = false
        for i = 1, #context.scoring_hand do
            if context.scoring_hand[i]:get_id() == 14 then has_ace = true; break end
        end
        if has_ace then
          if context.scoring_name == "Four of a Kind" then
            card.ability.extra.chips = card.ability.extra.chips + 2 * card.ability.extra.chip_mod
          else
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
          end
        end
      end
      if context.joker_main then
        
        return {
          message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}, 
          colour = G.C.CHIPS,
          chip_mod = card.ability.extra.chips,
        }
      end
    end
    return scaling_evo(self, card, context, "j_poke_metang", card.ability.extra.chips, 64)
  end,
}
-- Metang 375
local metang={
  name = "metang", 
  pos = {x = 6, y = 12},
  config = {extra = {chips = 0, chip_mod = 8, size = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.chips, center.ability.extra.chip_mod, center.ability.extra.size}}
  end,
  rarity = "poke_safari", 
  cost = 8, 
  stage = "One", 
  ptype = "Metal",
  atlas = "Pokedex3",
  perishable_compat = false,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.before and not context.blueprint then
        local ace_count = 0
        for i = 1, #context.scoring_hand do
            if context.scoring_hand[i]:get_id() == 14 then ace_count = ace_count + 1 end
        end
        if ace_count > 1 then
          if context.scoring_name == "Four of a Kind" then
            card.ability.extra.chips = card.ability.extra.chips + 4 * card.ability.extra.chip_mod
          else
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
          end
        end
      end
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}, 
          colour = G.C.CHIPS,
          chip_mod = card.ability.extra.chips,
          card = card
        }
      end
    end
    return scaling_evo(self, card, context, "j_poke_metagross", card.ability.extra.chips, 256)
  end,
}
-- Metagross 376
local metagross={
  name = "metagross", 
  pos = {x = 7, y = 12},
  config = {extra = {chips = 256,}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.chips}}
  end,
  rarity = "poke_safari", 
  cost = 10, 
  stage = "Two", 
  ptype = "Metal",
  atlas = "Pokedex3",
  perishable_compat = false,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}, 
          colour = G.C.CHIPS,
          chip_mod = card.ability.extra.chips,
          card = card
        }
      end
    end
    if context.individual and context.cardarea == G.play and not context.end_of_round and context.scoring_name and context.scoring_name == "Four of a Kind" then
      local total_chips = poke_total_chips(context.other_card)
      local Xmult = (total_chips)^(1/3)
      if Xmult > 0 then
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {Xmult}},
          colour = G.C.XMULT,
          mult = card.ability.extra.mult_mod, 
          x_mult = Xmult,
          card = card
        }
      end
    end
  end,
}
-- Regirock 377
-- Regice 378
-- Registeel 379
-- Latias 380
-- Latios 381
-- Kyogre 382
-- Groudon 383
-- Rayquaza 384
-- Jirachi 385
local jirachi = {
  name = "jirachi",
  pos = {x = 4, y = 14},
  soul_pos = { x = 5, y = 14},
  config = {extra = {triggers = 0}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.triggers}}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Metal",
  atlas = "Pokedex3",
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.end_of_round
       and not context.individual
       and not context.repetition
       and not context.blueprint
    then
      if not card.ability.extra.resource_data then
        card.ability.extra.resource_data = {
          money       = 0,
          hand        = 0,
          discard     = 0,
          joker       = 0,
          consumable  = 0,
          hand_size   = 0,
        }
      end
      if card.ability.extra.triggers < 7 then
        local resource_keys = {"money", "hand", "discard", "joker", "consumable", "hand_size"}
        local function get_base_weight(r)
          local triggered_count = card.ability.extra.resource_data[r] or 0
          local base = 3 - triggered_count
          if base < 0 then base = 0 end
          return base
        end
        local weights = {}
        for _, r in ipairs(resource_keys) do
          weights[r] = get_base_weight(r)
        end
        local hands_left = G.GAME.current_round.hands_left or 0
        local discards_left = G.GAME.current_round.discards_left or 0
        local jokers_full = (G.jokers and G.jokers.config.card_limit <= #G.jokers.cards)
        local consumable_limit = (#G.consumeables.cards + G.GAME.consumeable_buffer) >= G.consumeables.config.card_limit
        local low_money = false
        if (SMODS.Mods["Talisman"] or {}).can_load then
          if to_big(G.GAME.dollars) < to_big(20) then
            low_money = true
          end
        else
          if G.GAME.dollars < 30 then
            low_money = true
          end
        end
        if hands_left <= 0 and weights["hand"] > 0 then
          weights["hand"] = weights["hand"] * 2
        end
        if discards_left <= 0 and weights["discard"] > 0 then
          weights["discard"] = weights["discard"] * 2
        end
        if jokers_full and weights["joker"] > 0 then
          weights["joker"] = weights["joker"] * 2
        end
        if consumable_limit and weights["consumable"] > 0 then
          weights["consumable"] = weights["consumable"] * 2
        end
        if low_money and weights["money"] > 0 then
          weights["money"] = weights["money"] * 2
        end
        local sum = 0
        for _, r in ipairs(resource_keys) do
          sum = sum + weights[r]
        end
        if sum > 0 then
          local roll = pseudorandom('jirachi'..pseudoseed('round'..G.GAME.round_resets.ante)) * sum
          roll = math.floor(roll) + 1
          local choice = nil
          local accum = 0
          for _, r in ipairs(resource_keys) do
            accum = accum + weights[r]
            if roll <= accum then
              choice = r
              break
            end
          end
          if choice then
            local msg = nil
            if choice == "money" then
              G.GAME.dollars = G.GAME.dollars + 1
              msg = "+1 dollar"
            elseif choice == "hand" then
              G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
              ease_hands_played(1)
              msg = "+1 hand"
            elseif choice == "discard" then
              G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
              ease_discard(1)
              msg = "+1 discard"
            elseif choice == "joker" then
              G.jokers.config.card_limit = G.jokers.config.card_limit + 1
              msg = "+1 joker slot"
            elseif choice == "consumable" then
              G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
              msg = "+1 consumable slot"
            elseif choice == "hand_size" then
              G.hand:change_size(1)
              msg = "+1 hand size"
            end
            if msg then
              card_eval_status_text(
                card, 'extra', nil, nil, nil,
                {message = msg.."!"}
              )
            end
            card.ability.extra.triggers = card.ability.extra.triggers + 1
            card.ability.extra.resource_data[choice] = card.ability.extra.resource_data[choice] + 1
            if card.ability.extra.triggers >= 7 then
              remove(self, card, context)
              card_eval_status_text(
                card, 'extra', nil, nil, nil,
                {message = "Jirachi has granted all its wishes!"}
              )
            end
          end
        end
      end
    end
  end
}
-- Deoxys 386
-- Turtwig 387
-- Grotle 388
-- Torterra 389
-- Chimchar 390
return {name = "Pokemon Jokers 361-390", 
        list = {snorunt, glalie, beldum, metang, metagross, jirachi},
}
