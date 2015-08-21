gulp = require('gulp')
concat = require('gulp-concat')
del = require('del')
revall = require('gulp-rev-all')
minifyCSS = require('gulp-minify-css')
uglify = require('gulp-uglify')


# Build the development site
gulp.task 'build/dist', [
  'build/dist/index.html'
  'build/dist/app.js'
  'build/dist/app.css'
  'build/dist/images'
  'build/dist/bower/fonts'
], ->
  # Delete the temp files after we're done. With some work, we could get rid
  # of the need for a temp directory, but it would complicate the tasks quite
  # a bit (more).
  del.sync(['build/dist.tmp'])


gulp.task 'build/dist/app.js', ['build/dist/bower.js', 'build/dist/main.js'], ->
  # Delete any destination file (since the filename might be different)
  del.sync(['build/dist/app.*.js'])

  gulp.src(['build/dist.tmp/bower.*.js', 'build/dist.tmp/main.*.js'])
    .pipe(concat('app.js'))
    .pipe(uglify())
    .pipe(revall())
    .pipe(gulp.dest('build/dist'))


gulp.task 'build/dist/app.css', ['build/dist/main.css', 'build/dist/bower.css'], ->
  # Delete any destination file (since the filename might be different)
  del.sync(['build/dist/app.*.css'])

  gulp.src(['build/dist.tmp/bower.*.css', 'build/dist.tmp/main.*.css'])
    .pipe(concat('app.css'))
    .pipe(minifyCSS())
    .pipe(revall())
    .pipe(gulp.dest('build/dist'))
