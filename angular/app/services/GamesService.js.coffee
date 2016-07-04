module.exports = ($http, $q, SERVER_URI) -> {
    GetAll: ->
        q = $q.defer()
        $http.get(SERVER_URI + '/games/list')
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Get: (id) ->
        q = $q.defer()
        $http.get(SERVER_URI + '/games/' + id)
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Add: (game) ->
      q = $q.defer()
      $http.post(SERVER_URI + '/games/', game)
      .success (data) ->
        q.resolve(data)
        return
      return q.promise
    New: ->
      q = $q.defer()
      $http.get(SERVER_URI + '/games/new')
      .success (data) ->
        q.resolve(data)
        return
      return q.promise
  }

module.exports.$inject = ['$http', '$q', 'SERVER_URI']
