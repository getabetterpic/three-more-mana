class CardSearcher
  attr_reader :params, :cards

  def initialize(cards)
    @cards = cards
  end

  def search(params)
    @params = params
    if params[:q].present?
      search_text
    elsif !params[:set].present?
      only_released_cards
    end
    search_legalities
    search_ids
    search_mana_cost
    search_cmc
    search_sets
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
    @cards = cards.modern_legal if check_modern?
  end

  def search_ids
    @cards = cards.where(uuid: params[:ids]) if params[:ids].present?
  end

  def search_mana_cost
    @cards = cards.where('mana_cost ILIKE ?', "%#{params[:mana_cost]}%") if params[:mana_cost].present?
  end

  def search_cmc
    @cards = cards.where('cmc = ?', params[:cmc]) if params[:cmc].present?
  end

  def search_sets
    @cards = cards.where('mtg_sets.code = ?', params[:set]) if params[:set].present?
  end

  def check_standard?
    params[:standard_legal] == 'true'
  end

  def check_modern?
    params[:modern_legal] == 'true'
  end
end
