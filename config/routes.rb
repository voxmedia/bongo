Rails.application.routes.draw do
  resources :projects do
    get :details
    resources :font_sets do
      get :info
    end
  end

  root 'projects#index'
end
