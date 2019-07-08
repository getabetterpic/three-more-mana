class CardSearcher
  attr_reader :params, :cards

  def initialize(cards)
    @cards = cards
  end

  def search(params)
    @params = params
    if params[:q].present?
      search_text
    else
      only_released_cards
    end
    search_legalities
    search_ids
    cards
  end

  private

  def search_text
    @cards = cards.where('mtg_cards.name ILIKE ?', "%#{params[:q]}%")
               .or(cards.where('mtg_cards.oracle_text ILIKE ?', "%#{params[:q]}%"))
  end

  def only_released_cards
    @cards = cards.where("mtg_sets.released_at < ?", Date.current)
  end

  def search_legalities
    @cards = cards.standard_legal if check_standard?
  end

  def search_ids
    @cards = cards.where(uuid: params[:ids]) if params[:ids].present?
  end

  def check_standard?
    params[:standard_legal] == 'true'
  end
end
