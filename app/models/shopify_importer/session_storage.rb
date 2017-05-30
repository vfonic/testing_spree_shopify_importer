module ShopifyImporter
  class SessionStorage
    def self.store(session)
      SpreeShopifyImporter::Config[:shopify_domain] = session.url
      SpreeShopifyImporter::Config[:shopify_token] = session.token
    end

    def self.retrieve(_id = nil)
      domain = SpreeShopifyImporter::Config[:shopify_domain]
      token = SpreeShopifyImporter::Config[:shopify_token]

      return if domain.blank? || token.blank?

      ShopifyAPI::Session.new(domain, token)
    end
  end
end

# SpreeShopifyImporter::Config[:shopify_api_key]
# SpreeShopifyImporter::Config[:shopify_password]
# SpreeShopifyImporter::Config[:shopify_shop_domain]
