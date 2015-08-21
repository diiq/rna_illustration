gulp = require('gulp')
browserSync = require('browser-sync')
del = require('del')
path = require('path')
reload = browserSync.reload


gulp.task 'watch', ['watch/dev', 'watch/test']

gulp.task 'watch/dev', ['build/dev'], ->
  gulp.watch ['app/**/*.coffee', '!app/**/*Test.coffee', 'config/dev.coffee'], ['build/dev/js', 'jasmine', 'build/dev/index.html', reload]
  gulp.watch ['app/**/*.scss'], ['build/dev/css', ->]
  gulp.watch ['app/index.html'], ['build/dev/index.html', reload]

  # Watch for added and deleted files (only sass and coffee files)
  gulp.watch ['app/**/*.coffee', 'app/**/*.scss', 'bower_components/**/*.js', '!app/**/*Test.coffee'], (event) ->
    if event.type == "added"
      gulp.start 'build/dev/index.html', ->
        reload()
    if event.type == "deleted"
      del getDestPathFromSrcPath(event.path, 'build/dev'), ->
        gulp.start 'build/dev/index.html', ->
          reload()


  # Watch for changes to image files
  gulp.watch ['app/**/*.png', 'app/**/*.jpg', 'app/**/*.gif', 'app/**/*.svg', 'app/**/*.ico'], (event) ->
    if event.type == "added" or event.type == "changed"
      gulp.start 'build/dev/images', -> reload()
    if event.type == "deleted"
      del getDestPathFromSrcPath(event.path, 'build/dev'), -> reload()


gulp.task 'watch/test', ['build/test/unit', 'jasmine'], ->
  # Watch for and rebuild modified test files. No need to reload, as Karma
  # does that itself
  gulp.watch ['app/**/*Test.coffee'], ['jasmine']

  # Delete deleted test files. Again, Karma watches and reloads itself, so
  # deleting the source file is sufficient
  gulp.watch ['app/**/*Test.coffee'], (event) ->
    if event.type == "deleted"
      del getDestPathFromSrcPath(event.path, 'build/test')


# Gets a filename in 'build/' from a filename in 'app/'. Needed for when files
# are deleted and we don't know the deleted file's corresponding destination
# file.
getDestPathFromSrcPath = (srcFile, destDirectory) ->
  relPath = path.relative(path.resolve('app'), srcFile)
  destPath = path.resolve(destDirectory, relPath)
  switch path.extname(srcFile)
    when ".coffee"
      path.join(path.dirname(destPath), path.basename(destPath, ".coffee")) + ".js"
    when ".scss"
      path.join(path.dirname(destPath), path.basename(destPath, ".scss")) + ".css"
    else
      destPath
