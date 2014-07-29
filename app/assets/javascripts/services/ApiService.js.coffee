atm = angular.module('atm')

atm.factory "Veggie", ($resource)->
  return $resource("/api/veggies/:id")
    #return $resource('/api/veggies/')

atm.factory "Product", ($resource)->
  return $resource "/api/products/:productId",
    productId: "@_id"

atm.factory "Market", ($resource)->
  return $resource "/api/markets/:marketId",
    marketId: "@_id"

atm.factory "Transaction", ($resource, $http, $log) ->
  $resource "/api/products/:product_id/transactions", 
    product_id: '@product_id'
  ,
    query:
      method: 'GET'
      # isArray: true
      transformResponse: (data, headersGetter) -> 
        { data: JSON.parse data }

