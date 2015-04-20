gulp = require('gulp')
browserSync = require('browser-sync')
cache = require('gulp-cached')
concat = require('gulp-concat')
filter = require('gulp-filter')
gutil = require('gulp-util')
naturalSort = require('gulp-natural-sort')
path = require('path')
reload = browserSync.reload
revall = require('gulp-rev-all')
sass = require('gulp-sass')
sourcemaps = require('gulp-sourcemaps')


gulp.task 'build/dev/css', ->
  gulp.src('app/**/*.scss')
    .pipe(sourcemaps.init())
    .pipe(sass {
      includePaths: ['bower_components/', 'app/shared_styles', 'app/']
      onError: compileError
    })
    .pipe(sourcemaps.write())
    .pipe(naturalSort())
    .pipe(gulp.dest('build/dev'))
    .pipe(filter('**/*.css'))
    .pipe(cache('css'))
    .pipe(reload(stream: true))

gulp.task 'build/dist/main.css', ->
  gulp.src('app/**/*.scss')
    .pipe(sass(includePaths: ['bower_components/', 'app/shared_styles', 'app/']))
    .pipe(naturalSort())
    .pipe(concat('main.css'))
    .pipe(revall())
    .pipe(gulp.dest('build/dist.tmp'))


# This is here to make the terminal beep when SASS compilation fails
compileError = (error) ->
  fileName = path.relative(path.resolve(__dirname, '..'), error.file)
  gutil.beep()
  gutil.log(
    gutil.colors.red("SASS error") +
    gutil.colors.white(" (") +
    gutil.colors.magenta("#{fileName}:#{error.line}") +
    gutil.colors.white("): ") +
    gutil.colors.white(error.message)
  )
