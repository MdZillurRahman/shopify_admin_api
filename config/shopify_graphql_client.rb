require 'httparty'
require 'json'

module ShopifyGraphQLClient
 include HTTParty

 base_uri 'https://entry-try-shop.myshopify.com/admin/api/2022-01/graphql.json'

 def self.call(query:, variables: {}, access_token: '102fb9366eb9f3410397b3d8dd672c41-1697651380')
    headers = {
      'Content-Type' => 'application/json',
      'X-Shopify-Access-Token' => access_token
    }

    body = {
      'query' => query,
      'variables' => variables
    }.to_json

    response = post('/', body: body, headers: headers)

    raise StandardError, "GraphQL query failed with response: #{response.body}" unless response.success?

    JSON.parse(response.body)['data']
 end
end