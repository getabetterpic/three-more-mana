class MtgCardsController < ApplicationController
  def index
    @cards = MtgCard.legal.includes(:set).joins(:set).order("mtg_sets.released_at DESC")
    @cards = @cards.standard_legal if params[:standard_legal] == 'true'
    @cards = @cards.where('mtg_cards.name ILIKE ?', "%#{params[:q]}%") if params[:q].present?
    @cards = @cards.page(params[:page]).per(25)
  end
end
