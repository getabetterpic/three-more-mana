module DeckCardsExtension
  def <<(card, count = 1)
    if dc = proxy_association.owner.deck_cards.find_by(card: card)
      dc.increment_count!(count)
    else
      super(card)
    end
  end

  def -(card)
    if dc = proxy_association.owner.deck_cards.find_by(card: card)
      dc.decrement_count!
    else
      super(card)
    end
  end

  def count_by_name
    proxy_association.owner.deck_cards.joins(:card).group(:name).sum(:card_count)
  end

  def count(column_name = nil)
    proxy_association.owner.deck_cards.sum(:card_count)
  end
end
