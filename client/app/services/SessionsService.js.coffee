module.exports = ($http, $q, SERVER_URI) -> {
    GetAll: ->
        q = $q.defer()
        $http.get(SERVER_URI + '/sessions/list')
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Get: (id) ->
        q = $q.defer()
        $http.get(SERVER_URI + '/sessions/' + id)
        .success (data) ->
          q.resolve(data)
          return
        return q.promise
    Add: (session) ->
      q = $q.defer()
      $http.post(SERVER_URI + '/sessions/', session)
      .success (data) ->
        q.resolve(data)
        return
      return q.promise
  }

module.exports.$inject = ['$http', '$q', 'SERVER_URI']
