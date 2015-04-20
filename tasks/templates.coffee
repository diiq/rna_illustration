gulp = require('gulp')
htmlmin = require('gulp-htmlmin')
naturalSort = require('gulp-natural-sort')
revall = require('gulp-rev-all')
templateCache = require('gulp-angular-templatecache')


gulp.task 'build/dev/templates', ->
  gulp.src(['app/**/*.html', '!app/index.html', '!app/external_scripts/**/*'])
    .pipe(htmlmin({
      collapseWhitespace: true
      conservativeCollapse: true
    }))
    .pipe(templateCache({
      module: 'angularSeed'
      root: '/'
    }))
    .pipe(gulp.dest('build/dev'))

gulp.task 'build/dist/templates.js', ->
  gulp.src(['app/**/*.html', '!app/index.html', '!app/external_scripts/**/*'])
    .pipe(htmlmin({
      collapseWhitespace: true
      conservativeCollapse: true
    }))
    .pipe(naturalSort())
    .pipe(templateCache({
      module: 'angularSeed'
      root: '/'
    }))
    .pipe(revall())
    .pipe(gulp.dest('build/dist.tmp'))
