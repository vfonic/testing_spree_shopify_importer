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
      end
    end
  end
end
