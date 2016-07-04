module.exports = ($scope, $stateParams, PlayersService) ->
  PlayersService.Get($stateParams.id)
    .then (data) ->
      $scope.player = data
      return

module.exports.$inject = ['$scope', '$stateParams', 'PlayersService']
