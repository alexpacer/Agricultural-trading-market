atm = angular.module('atm')

atm.factory "Veggie", ($resource)->
  return $resource("/api/veggies/:id")
    #return $resource('/api/veggies/')

atm.factory "Product", ($resource)->
  return $resource "/api/products"