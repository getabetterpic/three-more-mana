Rails.application.routes.draw do
  post '/users/sign_in' => 'sessions#create'

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :cards, controller: :mtg_cards, only: [:index, :show], concerns: :paginatable
      resources :decks, only: [:show, :index], concerns: :paginatable
      resources :sets, controller: :mtg_sets, only: [:index]
    end
  end
end
