class Api::V1::MtgCardsController < Api::V1Controller
  def show
    @card = MtgCard.find_by(uuid: params[:id])
  end

  def index
    @cards = MtgCard.legal.not_land
              .includes(:set).joins(:set).order("mtg_sets.released_at DESC")
    @cards = @cards.where("mtg_sets.released_at < ?", Date.today) unless params[:q].present?
    @cards = @cards.standard_legal if params[:standard_legal] == 'true'
    @cards = @cards.where('mtg_cards.name ILIKE ?', "%#{params[:q]}%") if params[:q].present?
    @cards = @cards.page(params[:page]).per(30)
  end
end
