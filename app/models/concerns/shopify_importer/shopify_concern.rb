module ShopifyImporter
  module ShopifyConcern
    extend ActiveSupport::Concern

    included do
      include ShopifyApp::SessionsConcern

      def shop_session
        @shop_session ||= ShopifyApp::SessionRepository.retrieve(nil)
      end

      protected

      def redirect_to_login
        if request.xhr?
          head :unauthorized
        else
          session[:return_to] = request.fullpath if request.get?
          redirect_to '/admin/shopify-importer/new'
        end
      end
    end
  end
end
