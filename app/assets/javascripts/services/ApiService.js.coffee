atm = angular.module('atm')

atm.factory "Veggie", ['$resource', ($resource)->
  return $resource("/api/veggies/:id")
    #return $resource('/api/veggies/')
]

atm.factory "Product", ['$resource', ($resource)->
  return $resource "/api/products/:productId",
    productId: "@_id"
  ,
    selectData:
      method: 'GET'
      transformResponse: (data, headersGetter)->
        products = JSON.parse data
        result = []
        i = 0
        while i < products.length
          result.push 
            id: products[i]._id
            text: products[i].code + ' ' + products[i].name
          i++
        { data: result }
]

atm.factory "Market", ['$resource', ($resource)->
  return $resource "/api/markets/:marketId",
    marketId: "@_id"
  ,
    selectData:
      method: 'GET'
      transformResponse: (data, headersGetter)->
        markets = JSON.parse data
        result = []
        i = 0
        while i < markets.length
          result.push 
            id: markets[i].code
            text: markets[i].code + ' ' + markets[i].name
          i++
        { data: result }
]

atm.factory "Transaction", ['$resource', ($resource, $http, $log) ->
  $resource "/api/products/:product_id/transactions", 
    product_id: '@product_id'
  ,
    query:
      method: 'GET'
      # isArray: true
      transformResponse: (data, headersGetter) -> 
        { data: JSON.parse data }
]