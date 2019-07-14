Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :cards, controller: :mtg_cards, only: [:index, :show], concerns: :paginatable
      resources :sets, controller: :mtg_sets, only: [:index]
    end
  end
end
