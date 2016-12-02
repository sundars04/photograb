Rails.application.routes.draw do
  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  get 'notifications', to: 'notifications#index'

  get 'profiles/show'

  devise_for :users
  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end



  root :to => 'posts#index'
end
