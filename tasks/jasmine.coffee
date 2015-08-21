gulp = require('gulp')
jasmine = require('gulp-jasmine')
depsOrder = require('gulp-deps-order')
naturalSort = require('gulp-natural-sort')
concat = require('gulp-concat')

gulp.task 'jasmine', ['build/dev', 'build/test/unit'], ->
  gulp.src('build/dev/**/*Test.js')
    .pipe(jasmine(
      vendor: ['build/dev/bower_components/**/**.js', 'build/dev/**/**.js']
      jasmineVersion: '2.3'

      ))
