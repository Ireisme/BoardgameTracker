angular.module('BoardgameTracker')
.controller 'HomeCtrl', [
  '$scope'
  '$log'
  '$state'
  '$timeout'
  '$location'
  '$interpolate'
  ($scope, $log, $state, $timeout, $location, $interpolate) ->
    $scope.$on '$stateChangeSuccess', (event, toState, toParams) ->
      current = $state.$current
      interpolationContext = if typeof current.locals != 'undefined' then current.locals.globals else current
      $scope.Title = $interpolate(current.title)(interpolationContext)
      return
]
