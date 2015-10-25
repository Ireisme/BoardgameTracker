angular.module('BoardgameTracker')
.controller 'PlayersAddCtrl', [
  '$scope', 
  '$stateParams', 
  '$state', 
  'PlayersService', 
  ($scope, $stateParams, $state, PlayersService) ->
    $scope.add = -> 
    	PlayersService.Add($scope.player)
      .then (data) -> 
        $state.go('home.players.view', { id: data })
        return
    $scope.cancel = ->
      $state.go('home.players.all')
      return
  ]