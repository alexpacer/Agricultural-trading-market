atm = angular.module('atm')

atm.controller 'VeggieController', 
  ['$scope', '$log', '$translate', '$filter', 'Market', 'Product', 'Transaction', 
    ($scope, $log, $translate, $filter, Market, Product, Transaction)->
    
      # variables
      $scope.pageStatus = ""
      $scope.productSelected = undefined
      $scope.marketSelected   = {}
      $scope.products = Product.query()

      $scope.transactions = undefined
      
      $scope.draw = ()->
        $scope.transactions = undefined
        markets = $("input[name='markets']").select2("val")
        product = $.grep($scope.products, (e)->
          e._id == $scope.productSelected)[0]

        productName = product.name + " " + (if (product.type != "" || product.type != undefined) then " (" + product.type + ")" else "")

        Transaction.query
          product_id: $scope.productSelected
          markets: markets.join(",")
        , (result)->
          $scope.transactions = result.data

          if result.data.length <= 0 
            return

          $("#container").highcharts "StockChart",
            chart:
              type: "columnrange"

            title:
              text: $scope.productSelected.name

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
                  text: $filter('translate')('VEGGIE_VOLUME')

                top: "65%"
                height: "35%"
                offset: 0
                lineWidth: 2
              }
            ]

            series: [
              {
                name: productName
                data: result.data.data
              }
              {
                name: $filter('translate')('VEGGIE_VOLUME')
                type: "areaspline"
                data: result.data.volumes
                yAxis: 1
              }
            ]

          return
          

      # ajax init methods
      Market.selectData().$promise.then (res)->
        console.log res.data

        $("input[name='markets']").select2
          data: res.data
          maximumInputLength: 8 
          multiple: true
          width: '500px'
  ]

