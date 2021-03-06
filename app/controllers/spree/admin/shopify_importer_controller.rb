module Spree
  module Admin
    class ShopifyImporterController < Spree::Admin::BaseController
      include ::ShopifyImporter::ShopifyConcern

      helper 'spree/base'

      include Spree::Core::ControllerHelpers::Auth
      include Spree::Core::ControllerHelpers::Common
      include Spree::Core::ControllerHelpers::Store

      helper 'spree/admin/navigation'
      layout 'spree/layouts/admin'

      around_action :shopify_session, only: :index

      def index; end

      def destroy
        SpreeShopifyImporter::Config[:shopify_domain] = nil
        SpreeShopifyImporter::Config[:shopify_token] = nil
        ShopifyAPI::Base.clear_session
        redirect_to '/admin/shopify-importer/new'
      end
    end
  end
end
