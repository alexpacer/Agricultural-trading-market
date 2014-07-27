atm = angular.module('atm')

atm.controller 'VeggieController', ($scope, $log, Product, Transaction)->
  
  # variables
  $scope.productsSelected = {}
  $scope.products = Product.query()
  $scope.transactions = []


  $scope.draw = ()->
    Transaction.query
      product_id: $scope.productsSelected
    , (result)->
      console.log result.data

      $("#container").highcharts "StockChart",
        title:
          text: $scope.productsSelected.name

        rangeSelector:
          buttons: [
            {
              type: "hour"
              count: 1
              text: "1h"
            }
            {
              type: "day"
              count: 1
              text: "1D"
            }
            {
              type: "all"
              count: 1
              text: "All"
            }
          ]
          selected: 1
          inputEnabled: false

        series: [
          name: "AAPL"
          type: "candlestick"
          data: result.data
          #   [
          #   [1357084800000,35.3,60,31.2,23],[1357084800000,35.3,60,31.2,23]
          # ] #$scope.transactions
          #transactions
          tooltip:
            valueDecimals: 2
        ]

      return
    
  
  # page actions
  # $.getJSON "http://www.highcharts.com/samples/data/jsonp.php?filename=new-intraday.json&callback=?", (data) ->
  
  #   # create the chart
  #   $("#container").highcharts "StockChart",
  #     title:
  #       text: "AAPL stock price by minute"

  #     rangeSelector:
  #       buttons: [
  #         {
  #           type: "hour"
  #           count: 1
  #           text: "1h"
  #         }
  #         {
  #           type: "day"
  #           count: 1
  #           text: "1D"
  #         }
  #         {
  #           type: "all"
  #           count: 1
  #           text: "All"
  #         }
  #       ]
  #       selected: 1
  #       inputEnabled: false

  #     series: [
  #       name: "AAPL"
  #       type: "candlestick"
  #       data: data
  #       tooltip:
  #         valueDecimals: 2
  #     ]

  #   return






  #
  # $('#container').highcharts
  #   chart:
  #     type: 'bar'

  #   title:
  #     text: 'Veggies'

  #   xAxis:
  #     categories: ['Apples', 'Bananas', 'Oranges']

  #   yAxis:
  #     title:
  #       text: 'fruit eaten'

  #   series:[
  #     {
  #       name: 'Jane'
  #       data: [1,0,4]
  #     }
  #     {
  #       name: 'Steward'
  #       data: [23,2,33]
  #     }
  #   ]

  $("select[name='products']").select2()

  # Loads products 
  # Product.query (data)->
  #   $scope.products = data




  console.log('VeggieController saying A-Lo')  
