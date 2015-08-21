gulp = require('gulp')
changed = require('gulp-changed')
coffee = require('gulp-coffee')
gutil = require('gulp-util')
plumber = require('gulp-plumber')
sourcemaps = require('gulp-sourcemaps')


gulp.task 'build/test/unit', ->
  gulp.src(['app/**/*Test.coffee'])
    .pipe(changed('build/test', extension: '.js'))
    .pipe(sourcemaps.init())
    .pipe(plumber(compileError))
    .pipe(coffee())
    .pipe(plumber.stop())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('build/test'))

# This is here mostly to make the terminal beep when CoffeeScript compilation fails
compileError = (error) ->
  gutil.beep()
  gutil.log(
    gutil.colors.red('CoffeeScript test compilation error:'),
    error.toString()
    )
