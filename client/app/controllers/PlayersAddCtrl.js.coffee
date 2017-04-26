module.exports = ($scope, $stateParams, $state, PlayersService) ->
    $scope.add = ->
    	PlayersService.Add($scope.player)
      .then (data) ->
        $state.go('home.players.view', { id: data })
        return
    $scope.cancel = ->
      $state.go('home.players.all')
      return

module.exports.$inject =['$scope', '$stateParams', '$state', 'PlayersService']
