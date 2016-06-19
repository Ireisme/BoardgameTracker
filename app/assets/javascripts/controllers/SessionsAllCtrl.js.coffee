angular.module('BoardgameTracker')
.controller 'SessionsAllCtrl', ['$scope', 'SessionsService', ($scope, SessionsService) ->
  SessionsService.GetAll()
    .then (data) ->
      $scope.games = data
      return
  ]
