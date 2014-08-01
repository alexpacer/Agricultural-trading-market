atm = angular.module('atm')

atm.controller 'VeggieController', 
  ['$scope', '$log', '$translate', '$filter', 'Market', 'Product', 'Transaction', 
    ($scope, $log, $translate, $filter, Market, Product, Transaction)->
    
      # variables
      $scope.products = Product.query()
      $scope.markets = Market.query()

      # ui variables
      $scope.pageStatus = ""
      $scope.productSelected = undefined
      $scope.marketSelected  = undefined
      $scope.transactions = undefined

      $scope.selectAllMarkets = ()->
        i = 0
        markets = []
        while $scope.markets.length > i
          markets.push($scope.markets[i].id)
          i++

        $("input[name='markets']").select2("val", markets)        
        return
      
      $scope.draw = ()->
        $scope.transactions = undefined
        $scope.pageStatus = $filter('translate')('MSG_LOADING')
        
        # grab selected product 
        prod = $.grep $scope.products, (node, index)->
          return node._id == $scope.productSelected
        prod = prod[0]

        product = $.grep($scope.products, (e)->
          e._id == $scope.productSelected)[0]

        productName = product.name + " " + (if (product.type != "" || product.type != undefined) then " (" + product.type + ")" else "")

        Transaction.query
          product_id: $scope.productSelected
          markets: $scope.marketSelected
        , (result)->
          $scope.transactions = result.data

          if result.data.length <= 0 
            $scope.pageStatus = $filter('translate')('MSG_NO_RECORDS_FOUND')
            return
          else
            $scope.pageStatus = ""

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
                    text: prod.name + ' - ' + prod.type

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
      # Market.selectData().$promise.then (res)->
      #   $scope.markets = res.data

      #   $("input[name='markets']").select2
      #     data: res.data
      #     maximumInputLength: 8 
      #     multiple: true
      #     width: '500px'
      #     placeholder: $filter('translate')('PH__FILTER_BY_MARKETS')
  ]

