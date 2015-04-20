angular.module 'angularSeed.homepage', [
  'ui.router'
]

angular.module('angularSeed.homepage').config ($stateProvider) ->
  $stateProvider
    .state 'homepage',
      url: '/'
      templateUrl: '/homepage/homepage.html'
      controller: 'HomepageCtrl as home'
