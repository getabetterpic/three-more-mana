namespace :cards do
  desc 'Complete refresh of cards'
  task refresh_cards: :environment do
    update_sets
    bulk_data = HTTParty.get('https://api.scryfall.com/bulk-data')
    file_to_get = bulk_data['data'].find { |d| d['type'] == 'default_cards' }['permalink_uri']
    cards = HTTParty.get(file_to_get)
    p_bar = ProgressBar.create(total: cards.length, title: 'Cards created:', format: '%t %c/%C: |%w%i| %e')
    old_level = Rails.logger.level
    Rails.logger.level = :info
    cards.each do |json|
      MtgCard.from_api(json)
      p_bar.increment
    end
    p_bar.finish
    Rails.logger.level = old_level
  end

  def update_sets
    sets = HTTParty.get('https://api.scryfall.com/sets')
    sets['data'].each do |json|
      MtgSet.from_api(json)
    end
  end
end
