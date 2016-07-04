module.exports = ($scope, PlayersService) ->
  PlayersService.GetAll()
    .then (data) ->
      $scope.players = data
      return

module.exports.$inject = ['$scope', 'PlayersService']
