module.exports = ($scope, SessionsService) ->
  SessionsService.GetAll()
    .then (data) ->
      $scope.games = data
      return

module.exports.$inject = ['$scope', 'SessionsService']
