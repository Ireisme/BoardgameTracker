angular.module('BoardgameTracker').factory 'SessionsService', [
  '$http', '$q'
  ($http, $q) -> {
    GetAll: ->
        q = $q.defer()
        $http.get('/sessions')
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Get: (id) ->
        q = $q.defer()
        $http.get('/sessions/' + id)
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Add: (session) ->
      q = $q.defer()
      $http.post('/sessions/', session)
      .success (data) ->
        q.resolve(data)
        return
      return q.promise
  }
]
