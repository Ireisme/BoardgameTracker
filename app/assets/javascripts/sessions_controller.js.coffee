# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("sessionApp", [])

app.controller "SessionNewCtrl", ["$scope", "$http", "$window", ($scope, $http, $window) ->
  $scope.name = "HEY THERE"
  $scope.session = {
    session_players: []
  }

  $http.get("/games/list").success (data) ->
    $scope.games = data
    return

  $http.get("/players/list", {params: {include_unknown: true}}).success (data) ->
    $scope.players = data
    return

  $scope.addToSession = (player) ->
    player.added = true
    $scope.session.session_players.push { player_id: player.id, player_name: player.name }
    return

  $scope.removeFromSession = (index) ->
    player_session = $scope.session.session_players[index]
    player = _.find($scope.players, (p) ->
      p.id is player_session.player_id
    )
    player.added = false
    $scope.session.session_players.splice index, 1
    return

  $scope.saveSession = () ->
    $http.post("/game/sessions", $scope.session).success (data) ->
      $window.location.href = data.url
      return
    return

  return
  ]