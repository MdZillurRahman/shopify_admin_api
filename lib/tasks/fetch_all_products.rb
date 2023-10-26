namespace :shopify do
    desc "Fetch all products and their variants"
    task fetch_all_products: :environment do
       query = <<-GRAPHQL
         {
           products(first: 250) {
             edges {
               node {
                 id
                 title
                 variants(first: 250) {
                   edges {
                    node {
                      id
                      price
                    }
                   }
                 }
               }
             }
           }
         }
       GRAPHQL
   
       response = ShopifyAPI::GraphQL.client.query(query)
       products = response.data.products.edges.map(&:node)
       products.each do |product|
         product.variants.edges.each do |variant_edge|
           variant = variant_edge.node
           # Do something with the product and variant data
         end
       end
    end
   end