sets = HTTParty.get('https://api.scryfall.com/sets')
sets['data'].each do |json|
  MtgSet.from_api(json)
end

Rake::Task['cards:refresh_cards'].execute
