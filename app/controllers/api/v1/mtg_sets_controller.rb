class Api::V1::MtgSetsController < Api::V1Controller
  def index
    @sets = MtgSet.order(released_at: :desc).all
  end
end
