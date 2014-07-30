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
    "HELLO": '你好'
    "BTN_DRAW_CHARTS": '繪圖'
    "VEGGIE_VOLUME": '總量'
    "LBL_PRODUCTS": "產品分類"
    "LBL_MARKETS": "市場"

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



# deprecated
atm.directive 'multiselectDropdawdawddown', [()->
  return (scope, element, attributes)->
    element = $(element[0])

    element.multiselect
      buttonClass: "btn btn-small"
      buttonWidth: "200px"
      buttonContainer: "<div class=\"btn-group\" />"
      maxHeight: 200
      enableFiltering: true
      enableCaseInsensitiveFiltering: true
      buttonText: (options) ->
        if options.length is 0
          element.data()["placeholder"] + " <b class=\"caret\"></b>"
        else if options.length > 1
          _.first(options).text + " + " + (options.length - 1) + " more selected <b class=\"caret\"></b>"
        else
          _.first(options).text + " <b class=\"caret\"></b>"

      
      # # Replicate the native functionality on the elements so
      # # that angular can handle the changes for us.
      # onChange: (optionElement, checked) ->
      #   optionElement.removeAttr "selected"
      #   optionElement.prop "selected", "selected"  if checked
      #   element.change()
      #   return


    # scope.$watch ()->
    #   element[0].length
    # ,
    #   ()-> 
    #     element.multiselect('rebuild')

    # scope.$watch attributes.ngModel, ()->
    #   element.multiselect('refresh')
]