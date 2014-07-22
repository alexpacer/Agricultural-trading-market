atm = angular.module('atm',['templates','ngRoute','ngResource'])

atm.config(['$routeProvider',($routeProvider)->
  $routeProvider
    .when('/',
      templateUrl: 'home/index.html'
      controller: 'AtmController'
    )
    .when('/veggie',
      templateUrl: 'veggie/index.html'
      controller: 'VeggieController'
    )
])
