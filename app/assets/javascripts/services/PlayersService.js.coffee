angular.module('BoardgameTracker').factory 'PlayersService', [
  '$http', '$q'
  ($http, $q) -> {
    GetAll: ->
        q = $q.defer()
        $http.get('/players/list')
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Get: (id) ->
        q = $q.defer()
        $http.get('/players/view/?id=' + id)
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Add: (player) ->
      q = $q.defer()
      $http.post('/players/', player)
      .success (data) ->
        q.resolve(data)
        return
      return q.promise
  }
]
