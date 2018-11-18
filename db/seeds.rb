resp = HTTParty.get('https://api.scryfall.com/sets')
resp['data'].each do |json|
  MtgSet.from_api(json)
end
