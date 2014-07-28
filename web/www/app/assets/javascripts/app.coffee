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
    HELLO: 'Hello'

  $translateProvider.translations 'zh', 
    HELLO: '你好'
    BTN_DRAW_CHARTS: '繪圖'
    VEGGIE_VOLUME: '總量'

  $translateProvider.preferredLanguage 'zh'

])