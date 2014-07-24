atm = angular.module('atm')

atm.controller 'VeggieController', ($scope, Product)->

  $scope.product = {}
  #$scope.product.selected = undefined
  $scope.products = []
  
  # page actions
  #
  $('#container').highcharts
    chart:
      type: 'bar'

    title:
      text: 'Veggies'

    xAxis:
      categories: ['Apples', 'Bananas', 'Oranges']

    yAxis:
      title:
        text: 'fruit eaten'

    series:[
      {
        name: 'Jane'
        data: [1,0,4]
      }
      {
        name: 'Steward'
        data: [23,2,33]
      }
    ]

  Product.query (data)->
    $scope.products = data    

  # $scope.search = (keyword)->
  #   Product.query 
  #     'keyword': keyword, (data)-> 
  #       $scope.products = data


  console.log('VeggieController saying A-Lo')  
