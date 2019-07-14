class Api::V1::DecksController < Api::V1Controller
  before_action :restrict_access

  def show
    @deck = current_user.decks.includes(deck_cards: :card).find_by(resource_id: params[:id])
  end

  def index
    @decks = current_user.decks.includes(:deck_cards)
  end
end
