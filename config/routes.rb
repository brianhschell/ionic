Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # 
  resource :dashboard do 
    get :home
  end
  resource :admin do 
    get :projects
    post :projects
    get :sub_details
    post :sub_details
    get :sub_breakdown
    post :sub_breakdown
    get :entry
    post :entry
    get :add_sub_type
    get :estimates
    post :estimates
    get :new_estimate
    post :new_estimate
    get :iview
  end

  root to: 'admins#projects'

  devise_for :users,  controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations',
    confirmations: 'user/confirmations',
    passwords: 'user/passwords',
    unlocks: 'user/unlocks',
    invitations: 'user/invitations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

end
