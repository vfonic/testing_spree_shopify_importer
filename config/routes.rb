Rails.application.routes.draw do
  mount Spree::Core::Engine, at: '/'

  root to: 'spree/admin/shopify_importer#index'

  get 'admin/shopify-importer/new', to: 'spree/admin/shopify_importer#new', as: :admin_new_shopify_importer_session
  get 'admin/shopify-importer', to: 'spree/admin/shopify_importer#index', as: :admin_shopify_importer
  match 'admin/shopify-importer', to: 'spree/admin/shopify_importer#destroy', via: :delete
  post 'admin/shopify-importer/import', to: 'spree/admin/shopify_importer/imports#create'
  match 'admin/shopify-importer/import', to: 'spree/admin/shopify_importer/imports#destroy', via: :delete

  mount ShopifyApp::Engine, at: '/'
end
