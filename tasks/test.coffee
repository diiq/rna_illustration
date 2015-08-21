gulp = require('gulp')
changed = require('gulp-changed')
coffee = require('gulp-coffee')
gutil = require('gulp-util')
plumber = require('gulp-plumber')
sourcemaps = require('gulp-sourcemaps')


gulp.task 'build/test/unit', ['build/test/unit/specs']

gulp.task 'build/test/unit/specs', ->
  gulp.src(['app/**/*Spec.coffee'])
    .pipe(changed('build/test', extension: '.js'))
    .pipe(sourcemaps.init())
    .pipe(plumber(compileError))
    .pipe(coffee())
    .pipe(plumber.stop())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('build/test'))

gulp.task 'build/test/e2e', ->
  gulp.src(['e2e-tests/**/*.coffee'])
    .pipe(changed('build/e2e-tests', extension: '.js'))
    .pipe(sourcemaps.init())
    .pipe(plumber(compileError))
    .pipe(coffee())
    .pipe(plumber.stop())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('build/e2e-tests'))

# This is here mostly to make the terminal beep when CoffeeScript compilation fails
compileError = (error) ->
  gutil.beep()
  gutil.log(
    gutil.colors.red('CoffeeScript test compilation error:'),
    error.toString()
    )
