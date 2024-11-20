Rottenpotatoes::Application.routes.draw do
    resources :movies
    get '/search', to: 'movies#search_tmdb'
    post '/search', to: 'movies#add_movie'

    # map '/' to be a redirect to '/movies'
    root :to => redirect('/movies')
  end
  