class ProductsController < ApplicationController
    def all_product
        session = ShopifyAPI::Auth::Session.new(
            shop: 'entry-try-shop.myshopify.com',
            access_token: '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'
        )

        query = <<~GQL
        {
            products(first: 10) {
               pageInfo {
                 hasNextPage
               }
               edges {
                 cursor
                 node {
                   id
                   title
                   handle
                   description
                   priceRange {
                     minVariantPrice {
                       amount
                       currencyCode
                     }
                     maxVariantPrice {
                       amount
                       currencyCode
                     }
                   }
                   images(first: 1) {
                     edges {
                       node {
                         src
                       }
                     }
                   }
                 }
               }
            }
           }
        GQL
        client = ShopifyAPI::Clients::Graphql::Admin.new(
            session: session
        )

        response = client.query(query: query)

        puts response.body.inspect
        @products= response.body["data"]["products"]["edges"]
        # binding.pry
        # shopify_service = ShopifyService.new
        # shop_data = shopify_service.get_shop_data
        # render json: shop_data
    end

    def add_product
      @categories = [
        'Clothing',
        'Shoes',
        'Accessories',
        'Bags',
        'Jewelry',
        'Watches',
        'Electronics',
        'Computers & Accessories',
        'Cell Phones & Accessories',
        'Camera & Photo',
        'Home & Kitchen',
        'Furniture',
        'Home Décor',
        'Bedding & Bath',
        'Kitchen & Dining',
        'Appliances',
        'Toys & Games',
        'Baby & Toddler',
        'Sports & Outdoors',
        'Exercise & Fitness',
        'Outdoor Recreation',
        'Team Sports',
        'Camping & Hiking',
        'Books',
        'Health & Household',
        'Vitamins & Dietary Supplements',
        'Personal Care',
        'Beauty',
        'Pet Supplies',
        'Automotive',
        'Industrial & Scientific',
        'Grocery & Gourmet Food',
        'Pet Supplies',
        'Handmade',
        'Others'
      ]

      session = ShopifyAPI::Auth::Session.new(
        shop: 'entry-try-shop.myshopify.com',
        access_token: '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'
    )

    query = <<~GQL
    {
      collections(first: 100) {
        nodes {
          id
          title
        }
      }
    }
    GQL

    client = ShopifyAPI::Clients::Graphql::Admin.new(
      session: session
  )
    
    @collections = client.query(query: query).body["data"]["collections"]["nodes"]
    
    end

    def create_product
        product_category = params[:category]
        product_collection = params[:collection]
        product_title = params[:productTitle]
        product_description = params[:productDescription]
        product_price = params[:productPrice]
        product_media = params[:files].present? ? params[:files] : nil
        product_options = params[:productOptions].present? ? params[:productOptions] : nil
        
        
        session = ShopifyAPI::Auth::Session.new(
          shop: 'entry-try-shop.myshopify.com',
          access_token: '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'
      )
      client = ShopifyAPI::Clients::Graphql::Admin.new(
        session: session
    )
      
        # mutation = <<-GQL
        #   mutation {
        #     productCreate(input: {
        #       title: "#{product_title}",
        #       descriptionHtml: "#{product_description}",
        #       productType: "#{product_category}",
        #       variants: {
        #         price: "#{product_price}"
        #       }
        #     }) {
        #       product {
        #         id
        #         title
        #       }
        #       userErrors {
        #         field
        #         message
        #       }
        #     }
        #   }
        # GQL

        media_array = []

        params[:files].each do |file, index|
          # Access the file and content-type from here
          # puts content_type = file.content_type
          # puts file_object = file.tempfile.open

          data = {
            "alt": file.original_filename,
            "mediaContentType": "IMAGE",
            # "originalSource": file.tempfile.open
            "originalSource": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgpJGuO4BZFBQF1_vfJtpiYBQxNR6Ud_oRHaOGy8H7&s"
          }

          media_array << data
         
          # Perform operations on the file as per your requirement
          # ...
         end

        query = <<~QUERY
        mutation productCreate($input: ProductInput!) {
          productCreate(input: $input) {
            product {
              id
              title
            }
            userErrors {
              field
              message
            }
          }
        }        
        QUERY
        variables = {
          "input": {
            "collectionsToJoin": [
              "#{product_collection}"
            ],
            "descriptionHtml": "#{product_description}",
            "productType": "#{product_category}",
            "published": true,
            "redirectNewHandle": true,
            "requiresSellingPlan": true,
            # "seo": {
            #   "description": "",
            #   "title": ""
            # },
            # "tags": [
            #   ""
            # ],
            "options": [
              ""
            ],
            "title": "#{product_title}",
            "variants": [
              {
                # "barcode": "",
                # "compareAtPrice": "",
                # "fulfillmentServiceId": "",
                # "harmonizedSystemCode": "",
                # "id": "",
                # "imageId": "",
                # "imageSrc": "",
                # "inventoryItem": {
                #   "cost": "",
                #   "tracked": true
                # },
                # "inventoryManagement": "",
                # "inventoryPolicy": "",
                # "inventoryQuantities": [
                #   {
                #     "availableQuantity": 1,
                #     "locationId": ""
                #   }
                # ],
                # "mediaId": "",
                # "mediaSrc": [
                #   ""
                # ],
                # "metafields": [
                #   {
                #     "description": "",
                #     "id": "",
                #     "key": "",
                #     "namespace": "",
                #     "type": "",
                #     "value": ""
                #   }
                # ],
                # "options": [
                #   ""
                # ],
                "position": 1,
                "price": "#{product_price}",
                "requiresComponents": false,
                "requiresShipping": true,
                "taxable": true,
                "weight": 1.1,
                # "weightUnit": ""
              }
            ]
          },
          "media": [media_array]
        }
        
      
       
          
        # @collections = client.query(query: query).body["data"]["collections"]["nodes"]
        response = client.query(query: query, variables: variables)

        puts response.inspect

        # if response.present? && response.body['data']['productCreate'].present? && response.body['data']['productCreate']['product'].present?
          
          # query = <<~QUERY
          #   mutation collectionAddProducts($id: ID!, $productIds: [ID!]!) {
          #     collectionAddProducts(id: $id, productIds: $productIds) {
          #       collection {
          #         id
          #         title
          #         productsCount
          #         products(first: 10) {
          #           nodes {
          #             id
          #             title
          #           }
          #         }
          #       }
          #       userErrors {
          #         field
          #         message
          #       }
          #     }
          #   }
          # QUERY
          # variables = {
          #   "id": "#{product_collection}",
          #   "productIds": ["#{response.body['data']['productCreate']['product']["id"]}"]
          # }
          # addedCollection = client.query(query: query, variables: variables)


          # puts addedCollection.inspect

          # redirect_to root_path
          # flash[:notice] = 'Product was successfully added.'

        # else
        #   redirect_to addProduct_path
        #   flash[:alert] = 'Failed to add product.'
        # end

        puts product_category
        puts product_collection
        puts product_title
        puts product_description
        puts product_price
        puts product_media
        puts media_array
        
        
          
      
        # Handle the response as per your requirements
      end
      

    # def add_product
        # puts product_title = params[:productTitle]
        # puts product_description = params[:productDescription]
        # puts product_price = params[:productPrice]
    # end

    def edit_product
    end

    # def fetch_products_from_shopify
    #     session = ShopifyAPI::Auth::Session.new(
    #         shop: 'entry-try-shop.myshopify.com',
    #         access_token: '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'
    #     )
    #     # client = ShopifyAPI::

    #     # response = 
    # end

    def update_product
    end
end
  