json.decks do
  json.array! @decks do |deck|
    json.id deck.resource_id
    json.name deck.name
    json.card_count deck.deck_cards.sum(:card_count)
    json.legalities do
      json.standard deck.standard_legal?
    end
  end
end
json.total_decks @decks.size