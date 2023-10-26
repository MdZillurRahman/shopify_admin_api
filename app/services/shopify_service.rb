class ShopifyService
#   def initialize
#     # puts "Hello"
#     # puts ShopifyAPI::Base
#     # puts "From the other side"
#     ShopifyAPI::Base.site = 'https://entry-try-shop.myshopify.com/admin/api/2023-10/graphql.json'
#     ShopifyAPI::Base.headers['X-Shopify-Access-Token'] = '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'
#   end

  def get_shop_data
    query = <<~GRAPHQL
      {
        shop {
          name
          email
          description
        }
      }
    GRAPHQL

    ShopifyAPI::GraphQL.new.query(query)
  end
end

