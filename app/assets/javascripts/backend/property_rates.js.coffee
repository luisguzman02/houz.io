#AngularJS
app = angular.module("PropertyRates", ["ngResource"])

app.config [ "$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
]

app.factory "PropertyRate", ["$resource", ($resource) ->
  $resource("/properties/:pid/rates/:id.json", {pid: "@pid", id: "@id"}, { updateAll: { method: 'POST', params: { }, isArray: true } } )
]

@PRatesController = ["$scope", "PropertyRate", ($scope, PropertyRate) ->

  $scope.$watch "concern_id", ->
    $scope.property_rates = PropertyRate.query({pid: $scope.concern_id})
  
  $scope.delete = (r,index) ->
    PropertyRate.delete r, ->
      $scope.property_rates.splice index, 1

  $scope.save = ->
    PropertyRate.updateAll {pid: $scope.concern_id}, {rates: $scope.property_rates}, ->
      $.howl
        type: "success"
        title: "Successfully saved"
        content: "Property rates were successfully saved."
        iconCls: "fa fa-check-square-o"

  $scope.addtoList = (id) ->
    $scope.property_rates.splice(0, 0, PropertyRate.get({id: id}))
]