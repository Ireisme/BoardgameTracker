angular.module('BoardgameTracker')
.directive 'menuLink', ->
  {
    scope: section: '='
    templateUrl: 'menu-link.html'
    link: ($scope, $element) ->
      controller = $element.parent().controller()

      $scope.focusSection = ->
        # set flag to be used later when
        # $locationChangeSuccess calls openPage()
        controller.autoFocusContent = true
        return

      return

  }
