Rails.application.routes.draw do
  root to: 'users#new'

  get    'users/new'   => 'users#new'
  post   'signup'       => 'users#create'

  get    'login'      => 'sessions#new'
  post   'login'      => 'sessions#create'
  delete 'logout'     => 'sessions#destroy'

  post   'games/move' => 'moves#create'

  resources :games, :moves

  match '*path', via: [:options], to: lambda {|_| [204, { 'Content-Type' => 'text/plain' }]}

  mount ActionCable.server, at: '/cable'
end
