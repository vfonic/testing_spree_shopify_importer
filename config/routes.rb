Rails.application.routes.draw do
  mount Spree::Core::Engine, at: '/'

  namespace :admin, path: Spree.admin_path do
    get 'shopify-importer' => 'shopify_importer#index', as: :shopify_importer
    get 'shopify-importer/new' => 'shopify_importer#new', as: :new_shopify_importer_session
  end

  mount ShopifyApp::Engine, at: "#{Spree.admin_path}/shopify-importer"
end
