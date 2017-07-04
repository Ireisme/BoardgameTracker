module.exports = ($scope, GamesService) ->
  GamesService.GetAll()
    .then (data) ->
      $scope.games = data
      return

module.exports.$inject = ['$scope', 'GamesService']
