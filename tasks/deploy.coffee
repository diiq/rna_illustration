gulp = require('gulp')
argv = require('yargs').argv
awspublish = require('gulp-awspublish')
awspublishRouter = require('gulp-awspublish-router')
parallelize = require('concurrent-transform')
_ = require('lodash')


gulp.task 'deploy', ['build/dist'], ->

  publisher = awspublish.create({ bucket: argv.bucket })

  gulp.src('build/dist/**/*')
    .pipe(awspublishRouter(
      routes:
        '^index.html$':
          gzip: true
          cacheTime: 30

        # gzip-able hashed assets (essentially app.js and app.css)
        '\.[0-9a-fA-F]{8}\.(?:js|css|svg|ttf|eot|otf)$':
          gzip: true
          cacheTime: 31536000

        # Any other hashed asset (images, fonts, etc)
        '\.[0-9a-fA-F]{8}\.':
          cacheTime: 31536000

        # gzip-able assets that aren't hashed (for some reason)
        '\.(?:js|css|svg|ttf|eot|otf)$':
          gzip: true

        # pass through all other files, 15 minute expiration
        '^.+$':
          cacheTime: 900
    ))
    .pipe(parallelize(publisher.publish(), 3))
    .pipe(publisher.sync())
    .pipe(awspublish.reporter())
