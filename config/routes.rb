Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :cards, controller: 'mtg_cards', only: [:index, :show], concerns: :paginatable, defaults: { format: :json }
end
