module.exports = ($http, $q) -> {
    GetAll: (unknown) ->
        q = $q.defer()
        $http.get('/players/list', { include_unknown: unknown })
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Get: (id) ->
        q = $q.defer()
        $http.get('/players/' + id)
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

module.exports.$inject = ['$http', '$q']
