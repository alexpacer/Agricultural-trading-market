atm = angular.module('atm')

atm.controller 'VeggieController', ($scope, $log, $translate, Product, Transaction)->
  
  # variables
  $scope.productsSelected = {}
  $scope.products = Product.query()
  $scope.transactions = []


  $scope.draw = ()->
    Transaction.query
      product_id: $scope.productsSelected
    , (result)->
      

      $("#container").highcharts "StockChart",
        chart:
          type: "columnrange"

        title:
          text: $scope.productsSelected.name

        rangeSelector:
          selected: 2
          inputEnabled: false

        yAxis: [
          {
            labels:
              align: "right"
              x: -3

            title:
              text: "OHLC"

            height: "60%"
            lineWidth: 2
          }
          {
            labels:
              align: "right"
              x: -3

            title:
              text: $translate('VEGGIE_VOLUME').translate

            top: "65%"
            height: "35%"
            offset: 0
            lineWidth: 2
          }
        ]

        series: [
          {
            name: "AAPL"
            data: result.data.data
          }
          {
            name: "volume"
            type: "areaspline"
            data: result.data.volumes
            yAxis: 1
          }
        ]

      return
    

  $("select[name='products']").select2()

  console.log('VeggieController saying A-Lo')  
