Rails.application.routes.draw do
  resources :projects do
    get :details
    resources :font_sets do
      get :info
      get :create_with_defaults, on: :collection
    end
  end

  root 'projects#index'
end
