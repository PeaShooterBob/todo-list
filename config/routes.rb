Rails.application.routes.draw do
  resources :projects do
    resources :items, :only => [:new, :create, :edit, :update], :controller => "projects/items"
    delete 'clear', :on => :member
  end
  root 'projects#index'
end
