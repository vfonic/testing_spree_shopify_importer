module Spree
  module Admin
    module ShopifyImporter
      class ImportsController < Spree::Admin::BaseController
        include ::ShopifyImporter::ShopifyConcern

        helper 'spree/base'

        include Spree::Core::ControllerHelpers::Auth
        include Spree::Core::ControllerHelpers::Common
        include Spree::Core::ControllerHelpers::Store

        helper 'spree/admin/navigation'
        layout 'spree/layouts/admin'

        around_action :shopify_session, only: :create

        def create
          ShopifyImport::Invoker.new.import!(
            credentials: {
              shop_domain: SpreeShopifyImporter::Config[:shopify_domain],
              token: SpreeShopifyImporter::Config[:shopify_token]
            }
          )
        end

        def destroy
          wipe_database

          create_admin_user

          ShopifyAPI::Base.clear_session

          redirect_to '/admin/shopify-importer/new'
        end

        private

        def wipe_database
          conn = ActiveRecord::Base.connection
          tables = ActiveRecord::Base.connection.tables
          tables.each { |t| conn.execute("TRUNCATE #{t}") }
        end

        def create_admin_user
          admin = Spree::User.new(email: 'spree@example.com', password: 'spree123', password_confirmation: 'spree123')
          if admin.save
            role = Spree::Role.find_or_create_by(name: 'admin')
            admin.spree_roles << role
            admin.save
            admin.generate_spree_api_key! if Spree::Auth::Engine.api_available?
          end
        end
      end
    end
  end
end
