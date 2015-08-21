gulp = require('gulp')
argv = require('yargs').argv
changed = require('gulp-changed')
coffee = require('gulp-coffee')
concat = require('gulp-concat')
fs = require('fs')
gutil = require('gulp-util')
depsOrder = require('gulp-deps-order')
naturalSort = require('gulp-natural-sort')
plumber = require('gulp-plumber')
revall = require('gulp-rev-all')
sourcemaps = require('gulp-sourcemaps')


gulp.task 'build/dev/js', ->
  gulp.src(['app/**/*.coffee', '!app/**/*Spec.coffee', 'config/dev.coffee'])
    .pipe(changed('build/dev', extension: '.js'))
    .pipe(sourcemaps.init())
    .pipe(plumber(compileError))
    .pipe(coffee())
    .pipe(plumber.stop())
    .pipe(sourcemaps.write())
    .pipe(depsOrder())
    .pipe(gulp.dest('build/dev'))

gulp.task 'build/dist/main.js', ->
  configFile = "config/#{argv.config}.coffee"

  if !fs.existsSync(configFile)
    console.error "Config file (#{configFile}) not found."
    process.exit(1)

  gulp.src(['app/**/*.coffee', '!app/**/*Spec.coffee', configFile])
    .pipe(coffee())
    .pipe(naturalSort())
    .pipe(depsOrder())
    .pipe(concat('main.js'))
    .pipe(revall())
    .pipe(gulp.dest('build/dist.tmp'))


# This is here to make the terminal beep when CoffeeScript compilation fails
compileError = (error) ->
  gutil.beep()
  gutil.log(
    gutil.colors.red('CoffeeScript compilation error:'),
    error.toString()
  )
