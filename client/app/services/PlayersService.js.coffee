module.exports = ($http, $q, SERVER_URI) -> {
    GetAll: (unknown) ->
        q = $q.defer()
        $http.get(SERVER_URI + '/players/list', { include_unknown: unknown })
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Get: (id) ->
        q = $q.defer()
        $http.get(SERVER_URI + '/players/' + id)
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Add: (player) ->
      q = $q.defer()
      $http.post(SERVER_URI + '/players/', player)
      .success (data) ->
        q.resolve(data)
        return
      return q.promise
  }

module.exports.$inject = ['$http', '$q', 'SERVER_URI']
