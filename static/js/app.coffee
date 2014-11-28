(->
  'use strict'

  app = angular.module('app', ['app.controllers', 'ngResource', 'ngRoute', 'ui.bootstrap', 'ui.date'])

  app.config ($routeProvider) ->
    $routeProvider
      .when('/', {
        templateUrl: 'views/home.html',
        controller: 'HomeCtrl'
        })
      .otherwise(redirectTo: '/')

  app
)()
