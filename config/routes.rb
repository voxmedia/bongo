Rails.application.routes.draw do

  resources :font_sets
  resources :projects

  root 'projects#index'

  get 'projects/:id/details' => 'projects#details', as: :project_details
  get ':project_id/:project_slug/:id/:slug' => 'font_sets#show', as: :show_font_set, constraints: {project_id: /\d+/, id: /\d+/}
  get 'font_set/info/:id' => 'font_sets#info', as: :font_set_info

  resources :projects do
    resources :font_sets
  end

end
