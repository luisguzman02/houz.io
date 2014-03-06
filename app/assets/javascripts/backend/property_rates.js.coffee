#AngularJS
app = angular.module("PropertyRates", ["ngResource"])

app.config [ "$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
]

app.factory "PropertyRate", ["$resource", ($resource) ->
  $resource("/properties/:pid/rates/:id.json", {pid: "@pid", id: "@id"})
]

@PRatesController = ["$scope", "PropertyRate", ($scope, PropertyRate) ->

  $scope.$watch "proid", ->
    $scope.property_rates = PropertyRate.query({pid: $scope.proid})
  
  $scope.delete = (r,index) ->
    PropertyRate.delete r, ->
      $scope.property_rates.splice index, 1

  $scope.addtoList = (id) ->
    $scope.property_rates.splice(0, 0, PropertyRate.get({id: id}))
]