angular.module('BoardgameTracker')
.directive 'menuToggle', [
  '$timeout'
  ($timeout) ->
    {
      scope: section: '='
      templateUrl: 'menu-toggle.html'
      link: ($scope, $element) ->
        controller = $element.parent().controller()

        $scope.isOpen = ->
          controller.isOpen $scope.section

        $scope.toggle = ->
          controller.toggleOpen $scope.section
          return

        return

    }
]