# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("sessionApp", ['ui.bootstrap'])

app.controller "SessionNewCtrl", ["$scope", "$http", "$window", 'dateFilter', ($scope, $http, $window, dateFilter) ->
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
    if (player.id > 0)
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

  $scope.open = (event) ->
    $scope.status.opened = true

  $scope.dateFormat = 'yyyy/MM/dd'
  $scope.session.played = dateFilter(new Date, $scope.dateFormat)

  $scope.status = {
    opened: false
  }

  $scope.maxDate = new Date

  return
  ]

app.directive 'dateOnlyFormat', (dateFilter) ->
  {
    require: 'ngModel',
    link: (scope, element, attr, ngModel) ->
      ngModel.$parsers.push (viewValue) ->
        dateFilter(viewValue, 'yyyy/MM/dd')
      return
  }