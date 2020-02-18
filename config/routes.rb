Rails.application.routes.draw do
  resources :artists do
    # routes to song(s) as a nested resource of artist
    # only routes to index and show for songs
    resources :songs, only: [:show, :index]
  end

  resources :songs
end