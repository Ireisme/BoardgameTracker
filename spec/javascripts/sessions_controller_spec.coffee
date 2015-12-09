#= require angular-mocks

describe 'SessionCtrl', ->
  beforeEach module('sessionApp')

  it 'can run tests', ->
    expect(true).to.be true

  it 'sets scope name to hey there', ->
    scope = {}
    http = {}
    window = {}
    controller = new SessionNewCtrl(scope, http, window)
    expect(scope.name).to.be 'HEY THERE'