(->
  'use strict'

  module = angular.module 'app.controllers'

  module.controller('HomeCtrl', ->
    @msg = 'Hello there!'
    )

  module
)()
