json.id @deck.resource_id
json.name @deck.name
json.mainboard @deck.mainboard
json.sideboard @deck.sideboard
json.legalities do
  json.standard_legal @deck.standard_legal?
end

