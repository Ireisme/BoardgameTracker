module.exports = ($scope, $log, $state, $timeout, $location, $interpolate, TitleService) ->
    $scope.$on '$stateChangeSuccess', (event, toState, toParams) ->
      current = $state.$current
      interpolationContext = if typeof current.locals != 'undefined' then current.locals.globals else current
      $scope.titleService = TitleService;
      TitleService.Title = $interpolate(current.title)(interpolationContext)
      return

module.exports.$inject = ['$scope', '$log', '$state', '$timeout', '$location', '$interpolate', 'TitleService']
