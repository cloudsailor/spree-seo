# frozen_string_literal: true

Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    resources :taxon_filter_combinations do
      member do
        delete :delete_icon
      end
    end
  end
end
