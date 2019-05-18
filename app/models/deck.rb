class Deck < ApplicationRecord
  validates :name, presence: true
  validates :user, presence: true

  belongs_to :user
  has_many :deck_cards, dependent: :destroy
  has_many :cards, -> { extending DeckCardsExtension }, through: :deck_cards

  def standard_legal?
    mainboard_hash = deck_cards.group(:mainboard).sum(:card_count)
    # Must have exactly 60 cards in the mainboard
    return false unless mainboard_hash[true] == 60
    # can have 0-15 cards in sideboard
    return false if mainboard_hash[false] && !mainboard_hash[false]&.in?(0..15)
    # Only basic lands can have more than 4 cards
    return false if deck_cards.joins(:card)
      .where("mtg_cards.type_line NOT LIKE 'Basic Land%'")
      .group("mtg_cards.name")
      .sum("deck_cards.card_count")
      .any? { |_, v| v > 4 }
    # Only standard legal non-basic lands are allowed
    return false unless cards.not_basic_land.all?(&:standard_legal?)
    true
  end

  def mainboard
    deck_cards.mainboard.includes(:card).map(&:card)
  end

  def sideboard
    deck_cards.sideboard.includes(:card).map(&:card)
  end

  def to_s
    str = ''
    deck_cards.mainboard.includes(:card).each do |dc|
      str += "#{dc.card_count}x #{dc.card.name}\n"
    end
    str
  end
end
