module.exports = ($scope, $state, $stateParams, Auth) ->
  $scope.login = ->
    Auth.login($scope.credentials)
    .then ->
      redirectTo = $stateParams.redirectTo
      if redirectTo
        params = JSON.parse($stateParams.redirectParams)
        $state.go redirectTo, params
      else
        $state.go 'home'
      return
    return

module.exports.$inject = ['$scope', '$state', '$stateParams', 'Auth']
