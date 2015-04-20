gulp = require('gulp')
karma = require('karma').server


# Karma options found here:
# http://karma-runner.github.io/0.12/config/configuration-file.html

fileList = [
  'dev/bower_components/angular/angular.js'
  'test/bower_components/angular-mocks.js'
  'dev/bower_components/**/*.js'
  'test/bower_components/**/*.js'
  'dev/**/*.js'
  'test/**/*.js'
]

gulp.task 'test/unit/watch', ['build/dev', 'build/test/unit'], ->
  karma.start({
    frameworks: ['jasmine', 'angular-filesort']
    browsers: ['PhantomJS']
    logLevel: 'WARN'
    autoWatch: true
    basePath: 'build/'
    files: fileList
  })

gulp.task 'test/unit/debug', ['build/dev', 'build/test/unit'], ->
  karma.start({
    frameworks: ['jasmine', 'angular-filesort']
    browsers: ['Chrome']
    logLevel: 'WARN'
    autoWatch: true
    basePath: 'build/'
    files: fileList
  })

gulp.task 'test/unit', ['build/dev', 'build/test/unit'], (cb) ->
  karma.start({
    frameworks: ['jasmine', 'angular-filesort']
    browsers: ['PhantomJS', 'Chrome', 'Firefox']
    singleRun: true
    basePath: 'build/'
    files: fileList
  }, cb)

gulp.task 'test/dist/unit', ['build/dist', 'build/test/unit'], (cb) ->
  karma.start({
    frameworks: ['jasmine']
    browsers: ['PhantomJS', 'Chrome', 'Firefox']
    singleRun: true
    basePath: 'build/'
    files: [
      'dist/app.*.js'
      'test/bower_components/angular-mocks.js'
      'test/**/*.js'
    ]
  }, cb)
