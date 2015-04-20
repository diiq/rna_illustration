gulp = require('gulp')
angularFilesort = require('gulp-angular-filesort')
argv = require('yargs').argv
bowerFiles = require('main-bower-files')
gulpif = require('gulp-if')
htmlmin = require('gulp-htmlmin')
inject = require('gulp-inject')
naturalSort = require('gulp-natural-sort')
revall = require('gulp-rev-all')


# Builds index.html, injecting a bunch of js and css file references
gulp.task 'build/dev/index.html', ['build/dev/js', 'build/dev/bower', 'build/dev/templates', 'build/dev/css'], ->

  # Get a stream of all bower dependencies (JS and CSS)
  bower = gulp.src(bowerFiles(), { base: "bower_components", read: false })

  # Get a stream of all our JS files (excluding bower files), sorted by angularFileSort()
  js = gulp.src(['**/*.js', '!bower_components/**/*', '!templates.js'], { cwd: 'build/dev' })
    .pipe(naturalSort())
    .pipe(angularFilesort())

  templates = gulp.src('templates.js', { cwd: 'build/dev', read: false })

  # Get a stream of all our compiled CSS files
  cssfiles = gulp.src(['**/*.css', '!bower_components/**/*.css', '!shared_styles/imports.css'], { cwd: 'build/dev', read: false, nodir: true })
    .pipe(naturalSort())

  # Inject filenames into index.html
  gulp.src('app/index.html')
    .pipe(inject(bower, name: 'bower'))
    .pipe(inject(js))
    .pipe(inject(cssfiles))
    .pipe(inject(templates, name: 'templates'))
    .pipe(inject gulp.src('app/external_scripts/*.html'),
      starttag: '<!-- inject:external_scripts:{{ext}} -->',
      transform: (filePath, file) ->
        file.contents.toString('utf8')
    )
    .pipe(gulp.dest('build/dev'))

# Builds index.html, injecting a bunch of js and css file references
gulp.task 'build/dist/index.html', ['build/dist/app.js', 'build/dist/app.css'], ->

  ourjs = gulp.src('app.*.js', { cwd: 'build/dist', read: false })
  cssfiles = gulp.src('app.*.css', { cwd: 'build/dist', read: false })

  # Inject filenames into index.html
  gulp.src('app/index.html')
    .pipe(inject(ourjs))
    .pipe(inject(cssfiles))
    .pipe(gulpif(argv.config != "production",
      inject gulp.src('app/external_scripts/*.html'),
        starttag: '<!-- inject:external_scripts:{{ext}} -->',
        transform: (filePath, file) ->
          file.contents.toString('utf8')
    ))
    .pipe(gulpif(argv.config == "production",
      inject gulp.src('app/external_scripts/**/*.html'),
        starttag: '<!-- inject:external_scripts:{{ext}} -->',
        transform: (filePath, file) ->
          file.contents.toString('utf8')
    ))
    .pipe(revall(ignore: [ /^\/index.html/ ]))
    .pipe(htmlmin({
      removeComments: true
      collapseWhitespace: true
    }))
    .pipe(gulp.dest('build/dist'))
