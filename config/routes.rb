Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'corona', to: 'corona#index'
      get 'corona/:date',to: 'corona#find_by_date', as: :corona_by_date
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
