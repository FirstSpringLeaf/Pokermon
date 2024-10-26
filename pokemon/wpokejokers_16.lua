-- Skorupi 451
-- Drapion 452
-- Croagunk 453
-- Toxicroak 454
-- Carnivine 455
-- Finneon 456
-- Lumineon 457
-- Mantyke 458
-- Snover 459
-- Abomasnow 460
-- Weavile 461
-- Magnezone 462
-- Lickilicky 463
-- Rhyperior 464
-- Tangrowth 465
-- Electivire 466
-- Magmortar 467
-- Togekiss 468
-- Yanmega 469
-- Leafeon 470
local leafeon={
  name = "leafeon", 
  pos = {x = 0, y = 0},
  config = {extra = {money = 2, suit = "Spades", rerolls = 0}},
  loc_txt = {      
    name = 'Leafeon',      
    text = {
      "Create a {C:attention}World{} card",
      "every {C:attention}3{} {C:green}rerolls{}",
      "Discarded cards with",
      "{C:spades}#2#{} suit earn {C:money}$#3#{}",
      "{C:inactive}(Must have room)",
      "{C:inactive}(Currently {C:attention}#1#{}{C:inactive}/3 rerolls)"
    } 
  },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.c_world
    return {vars = {center.ability.extra.rerolls, localize(center.ability.extra.suit, 'suits_singular'), center.ability.extra.money}}
  end,
  rarity = "poke_safari", 
  cost = 7, 
  stage = "One",
  ptype = "Grass",
  atlas = "Pokedex4",
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.reroll_shop and not context.blueprint then
      if card.ability.extra.rerolls < 2 then
        card.ability.extra.rerolls = card.ability.extra.rerolls + 1
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = card.ability.extra.rerolls.."/3", colour = G.C.TAROT})
        if card.ability.extra.rerolls == 2 then
          local eval = function() return card.ability.extra.rerolls == 2 end
          juice_card_until(card, eval, true)
        end
      else
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_world')
          _card:add_to_deck()
          G.consumeables:emplace(_card)
        end
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "3/3", colour = G.C.TAROT})
        card.ability.extra.rerolls = 0
      end
    end
    if context.discard and context.other_card:is_suit(card.ability.extra.suit) and not context.other_card.debuff and not context.blueprint then
      ease_dollars(card.ability.extra.money)
      return {
        message = localize('$')..card.ability.extra.money, 
        colour = G.C.MONEY
      }
    end
  end
}
-- Glaceon 471
local glaceon={
  name = "glaceon", 
  pos = {x = 0, y = 0},
  config = {extra = {rerolls = 0, odds = 6}},
  loc_txt = {      
    name = 'Glaceon',      
    text = {
      "Create a random {C:attention}Tarot{} card",
      "every {C:attention}3{} {C:green}rerolls{}",
      "{C:green}#2#{} in {C:green}#3#{} chance for {C:dark_edition}Negative{}",
      "{C:inactive}(Must have room)",
      "{C:inactive}(Currently {C:attention}#1#{}{C:inactive}/3 rerolls)"
    } 
  },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.rerolls, ''..(G.GAME and G.GAME.probabilities.normal or 1), center.ability.extra.odds}}
  end,
  rarity = "poke_safari", 
  cost = 7, 
  stage = "One",
  ptype = "Water",
  atlas = "Pokedex4",
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.reroll_shop and not context.blueprint then
      if card.ability.extra.rerolls < 2 then
        card.ability.extra.rerolls = card.ability.extra.rerolls + 1
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = card.ability.extra.rerolls.."/3", colour = G.C.TAROT})
        if card.ability.extra.rerolls == 2 then
          local eval = function() return card.ability.extra.rerolls == 2 end
          juice_card_until(card, eval, true)
        end
      else
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil)
          if pseudorandom('glaceon') < G.GAME.probabilities.normal/card.ability.extra.odds then
            local edition = {negative = true}
            _card:set_edition(edition, true)
          end
          _card:add_to_deck()
          G.consumeables:emplace(_card)
        end
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "3/3", colour = G.C.TAROT})
        card.ability.extra.rerolls = 0
      end
    end
  end
}
-- Gliscor 472
-- Mamoswine 473
-- Porygon-Z 474
-- Gallade 475
-- Probopass 476
-- Dusknoir 477
-- Froslass 478
-- Rotom 479
-- Uxie 480
return {name = "Pokemon Jokers 451-480", 
        list = {leafeon, glaceon},
}