class MtgCardsController < ApplicationController
  def show
    @card = MtgCard.find_by(uuid: params[:id])
  end

  def index
    @cards = MtgCard.legal.includes(:set).joins(:set).order("mtg_sets.released_at DESC")
    @cards = @cards.standard_legal if params[:standard_legal] == 'true'
    @cards = @cards.where('mtg_cards.name ILIKE ?', "%#{params[:q]}%") if params[:q].present?
    @cards = @cards.page(params[:page]).per(25)
  end
end
