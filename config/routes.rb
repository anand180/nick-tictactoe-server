Rails.application.routes.draw do
  root to: 'users#new'

  get    'users/new'   => 'users#new'
  post   'users'       => 'users#create'

  get    'login'      => 'sessions#new'
  post   'login'      => 'sessions#create'
  delete 'logout'     => 'sessions#destroy'

  post   'games/move' => 'moves#create'

  resources :games, :moves

  mount ActionCable.server, at: '/cable'
end
