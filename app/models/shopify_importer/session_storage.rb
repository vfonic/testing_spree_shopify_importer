module ShopifyImporter
  class SessionStorage
    def self.store(session)
      Spree::Config[:shopify_domain] = session.url
      Spree::Config[:shopify_token] = session.token
    end

    def self.retrieve(_id = nil)
      domain = Spree::Config[:shopify_domain]
      token = Spree::Config[:shopify_token]

      return if domain.blank? || token.blank?

      ShopifyAPI::Session.new(domain, token)
    end
  end
end

# Spree::Config[:shopify_api_key]
# Spree::Config[:shopify_password]
# Spree::Config[:shopify_shop_domain]
