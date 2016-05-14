angular.module('BoardgameTracker')
.controller 'HomeCtrl', [
  '$scope'
  '$log'
  '$state'
  '$timeout'
  '$location'
  '$interpolate'
  'menu'
  ($scope, $log, $state, $timeout, $location, $interpolate, menu) ->
    $scope.$on '$stateChangeSuccess', (event, toState, toParams) ->
      current = $state.$current
      interpolationContext = if typeof current.locals != 'undefined' then current.locals.globals else current
      $scope.Title = $interpolate(current.title)(interpolationContext)
      return

    vm = this
    isOpen = (section) ->
      menu.isSectionSelected section

    toggleOpen = (section) ->
      menu.toggleSelectSection section
      return

    isSectionSelected = (section) ->
      selected = false
      openedSection = menu.openedSection
      if openedSection == section
        selected = true
      else if section.children
        section.children.forEach (childSection) ->
          if childSection == openedSection
            selected = true
          return
      selected

    vm.isOpen = isOpen
    vm.toggleOpen = toggleOpen
    vm.isSectionSelected = isSectionSelected
    vm.autoFocusContent = false
    $scope.menu = menu
    console.log 'menu: ', vm.menu
    vm.status =
      isFirstOpen: true
      isFirstDisabled: false
    return
]