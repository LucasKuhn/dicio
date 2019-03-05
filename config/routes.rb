Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'anagram/:search', to: 'words#anagram', as: 'anagram'
  get 'scrabble/:search', to: 'words#scrabble', as: 'scrabble'
  get 'charade/:search', to: 'words#charade', as: 'charade'
  get 'find_numbers/:search', to: 'words#find_numbers', as: 'find_numbers'
  resources :words do
    collection do
      get 'search/:search', :action => 'search', :as => 'search'
    end
  end
end
