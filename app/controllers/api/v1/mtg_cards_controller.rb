class Api::V1::MtgCardsController < Api::V1Controller
  def show
    @card = MtgCard.find_by!(uuid: params[:id])
  end

  def index
    @cards = MtgCard.legal.not_basic_land
              .includes(:set).joins(:set).order("mtg_sets.released_at DESC")
    @cards = ::CardSearcher.new(@cards).search(params)
    @cards = @cards.page(params[:page]).per(30)
  end
end
