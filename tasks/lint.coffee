gulp = require('gulp')
coffeelint = require('gulp-coffeelint')
scsslint = require('gulp-scss-lint')


gulp.task 'lint', ['lint/coffee', 'lint/scss']

gulp.task 'lint/coffee', ->
  gulp.src(['app/**/*.coffee', 'e2e-tests/**/*.coffee'])
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())

gulp.task 'lint/scss', ->
  gulp.src('app/**/*.scss')
    .pipe(scsslint(config: 'tasks/scss_lint.yml', bundleExec: true))
    .pipe(scsslint.failReporter())
