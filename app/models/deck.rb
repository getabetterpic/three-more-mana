class Deck < ApplicationRecord
  validates :name, presence: true
  validates :user, presence: true

  belongs_to :user
  has_many :deck_cards, dependent: :destroy
  has_many :cards, -> { extending DeckCardsExtension }, through: :deck_cards

  def standard_legal?
    mainboard_hash = deck_cards.group(:mainboard).sum(:card_count)
    return false unless mainboard_hash[true] == 60
    return false if mainboard_hash[false] && !mainboard_hash[false]&.in?(0..15)
    return false if deck_cards.joins(:card)
      .where("mtg_cards.type_line NOT LIKE 'Basic Land%'")
      .group("mtg_cards.name")
      .sum("deck_cards.card_count")
      .any? { |k, v| v > 4 }
    return false if cards.not_basic_land.any? { |card| !card.standard_legal? }
    true
  end
end
