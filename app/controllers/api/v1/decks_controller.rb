class Api::V1::DecksController < Api::V1Controller
  def show
    @deck = Deck.find_by(resource_id: params[:id])
  end
end
