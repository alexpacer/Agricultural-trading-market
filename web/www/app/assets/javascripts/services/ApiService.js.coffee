atm = angular.module('atm')

atm.factory "Veggie", ($resource)->
  return $resource("/api/veggies/:id")
    #return $resource('/api/veggies/')

atm.factory "Product", ($resource)->
  return $resource "/api/products/:productId",
    productId: '@_id'
  # , 
  #   transactions: 
  #     method: 'GET'
  #     url: "/api/products/:productId/transactions"
  #     isArray: true


atm.factory "Transaction", ($resource) ->
  $resource "/api/products/:product_id/transactions", 
    product_id: '@product_id'
