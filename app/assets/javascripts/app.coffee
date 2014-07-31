# 'ui.select'

atm = angular.module('atm',['templates','ngRoute','ngResource', 'ngSanitize', 'pascalprecht.translate'])

atm.config(['$routeProvider',($routeProvider, uiSelectConfig)->
  $routeProvider
    .when('/',
      templateUrl: 'home/index.html'
      controller: 'AtmController'
    )
    .when('/veggies',
      templateUrl: 'veggies/index.html'
      controller: 'VeggieController'
    )
])


# atm.run(['uiSelect2Config', (uiSelect2Config)->
#   uiSelect2Config.placeholder = "Please select"
# ])

atm.config(['$translateProvider', ($translateProvider) ->
  $translateProvider.translations 'en',
    "HELLO": 'Hello'

  $translateProvider.translations 'zh', 
    # Messages
    "MSG_NO_RECORDS_FOUND": "查無資料" 

    # Buttons
    "BTN_DRAW_CHARTS": '繪圖'
    "BTN_SELECT_ALL": '全選'

    #Labels
    "LBL_PRODUCTS": "產品分類"
    "LBL_MARKETS": "市場"

    #Place holders
    "PH__FILTER_BY_MARKETS": "依市場過濾資料"

    "VEGGIE_VOLUME": '總量'

  $translateProvider.preferredLanguage 'zh'

])


atm.directive 'selectDropdown', [()->
  return (scope, element, attributes)->
    element = $(element[0])

    element.select2()

    scope.$watch ()->
      element[0].length
    ,
      ()-> 
        element.select2()

    scope.$watch attributes.ngModel, ()->
      element.select2()
]
