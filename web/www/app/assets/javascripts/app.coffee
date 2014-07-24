atm = angular.module('atm',['templates','ngRoute','ngResource', 'ngSanitize', 'ui.select'])

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
