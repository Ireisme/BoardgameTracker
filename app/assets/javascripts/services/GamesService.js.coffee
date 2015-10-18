angular.module('BoardgameTracker').factory 'GamesService', [
  '$http', '$q'
  ($http, $q) -> { 
    GetAll: ->
        q = $q.defer()
        $http.get('/games/list')
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Get: (id) ->
        q = $q.defer()
        $http.get('/games/view/?id=' + id)
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Add: (game) -> 
      q = $q.defer()
      $http.post('/games/', game)
      .success (data) ->
        q.resolve(data)
        return
      return q.promise
  }
]