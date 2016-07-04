module.exports = ($rootScope, $state, Auth, $templateCache) ->

  templates = require('./templates.js')
  templates($templateCache)

  $rootScope.$on '$stateChangeStart', (evt, next, nextParams, current, currentParams) ->
    params = undefined
    if next.name != 'login'
      console.log 'app.js.coffee'
      Auth.currentUser({ interceptAuth: false }).then ((user) ->
        console.log user
      ),
      (error) ->
        console.log 'error'
        evt.preventDefault()
        params = JSON.stringify(nextParams)
        $state.go 'login',
          redirectTo: next.name
          redirectParams: params
        return

    return

module.exports.$inject = ['$rootScope', '$state', 'Auth', '$templateCache']
