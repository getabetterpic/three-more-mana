json.cards do
  json.array! @cards do |card|
    json.id card.uuid
    json.name card.name
    json.set card.set.name
    json.layout card.layout
    json.image card.image_uris&.fetch('large', nil) || card.card_faces&.dig(0, 'image_uris', 'large')
    json.png card.image_uris&.fetch('png', nil) || card.card_faces&.dig(0, 'image_uris', 'png')
    json.art card.image_uris&.fetch('art_crop', nil) || card.card_faces&.dig(0, 'image_uris', 'art_crop')
    json.mana_cost card.mana_cost
    json.cmc card.cmc
    json.card_type card.type_line
    json.card_text card.oracle_text
    json.power card.power
    json.toughness card.toughness
    json.colors card.colors
    json.color_identity card.color_identity
    json.legalities card.legalities
    json.rarity card.rarity
    json.card_faces card.card_faces
  end
end
