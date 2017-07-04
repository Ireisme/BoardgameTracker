module.exports = ($http, $q, SERVER_URI) -> {
  Get: (id) ->
    q = $q.defer()
    $http.get(SERVER_URI + '/players/' + id + '/statistics')
    .success (data) ->
      q.resolve(data)
      return
    return q.promise
}

module.exports.inject = ['$http', '$q', 'SERVER_URI']
