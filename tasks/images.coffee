gulp = require('gulp')
imagemin = require('gulp-imagemin')
revall = require('gulp-rev-all')


imageFiles = ['app/**/*.png', 'app/**/*.jpg', 'app/**/*.gif', 'app/**/*.svg', 'app/**/*.ico']

gulp.task 'build/dev/images', ->
  gulp.src(imageFiles)
    .pipe(gulp.dest('build/dev'))

gulp.task 'build/dist/images',  ->
  gulp.src(imageFiles)
    .pipe(revall(ignore: [ /^\/static\// ]))
    .pipe(imagemin())
    .pipe(gulp.dest('build/dist'))
