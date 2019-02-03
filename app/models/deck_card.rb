class DeckCard < ApplicationRecord
  validates :deck, :card, presence: true
  validates :card_count, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validates :card_id, uniqueness: { scope: [:deck_id, :mainboard] }
  belongs_to :deck
  belongs_to :card, class_name: 'MtgCard'

  scope :mainboard, -> { where(mainboard: true) }
  scope :sideboard, -> { where(mainboard: false) }

  def increment_count!(count = 1)
    self.card_count += count
    save!
  end

  def decrement_count!(count = 1)
    self.card_count -= count
    save!
  end
end
