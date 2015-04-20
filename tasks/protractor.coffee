gulp = require('gulp')
connect = require('gulp-connect')
protractor = require('gulp-protractor').protractor
modRewrite = require('connect-modrewrite')
webdriver_start = require("gulp-protractor").webdriver_standalone
webdriver_update = require('gulp-protractor').webdriver_update


debug = false

# Runs end-to-end tests against a dev build. e2e tests get their own server on
# port 3001, so as to not interfere with the main dev server (and BrowserSync)
# on port 3001
gulp.task 'test/e2e', ['test/e2e/webserver', 'build/test/e2e', 'test/e2e/webdriver/update'], ->
  gulp.src(['build/e2e-tests/**/*.js'])
    .pipe(protractor(
      configFile: 'build/e2e-tests/protractor.config.js'
      debug: debug
    ))
    .on 'error', -> connect.serverClose()
    .on 'end', -> connect.serverClose()


# Same thing as above, but against dist
gulp.task 'test/dist/e2e', ['test/dist/e2e/webserver', 'build/test/e2e', 'test/e2e/webdriver/update'], ->
  gulp.src(['build/e2e-tests/**/*.js'])
    .pipe(protractor(
      configFile: 'build/e2e-tests/protractor.config.js'
      debug: debug
    ))
    .on 'error', -> connect.serverClose()
    .on 'end', -> connect.serverClose()


# Stops the tests at the point you say browser.debugger()
gulp.task 'test/e2e/debug', ->
  debug = true
  gulp.start 'test/e2e'

gulp.task 'test/dist/e2e/debug', ->
  debug = true
  gulp.start 'test/dist/e2e'


# This is for getting a repl on a specfic page only. Not normally used...
# Run node node_modules/protractor/bin/elementexplorer.js http://localhost:3001/some_page
# if you want a repl on some_page
gulp.task 'test/e2e/server', ['test/e2e/webserver', 'test/e2e/webdriver/start']

gulp.task 'test/e2e/webdriver/update', webdriver_update
gulp.task 'test/e2e/webdriver/start', webdriver_start
