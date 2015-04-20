gulp = require('gulp')
browserSync = require('browser-sync')
del = require('del')
path = require('path')
reload = browserSync.reload


gulp.task 'watch', ['watch/dev', 'watch/test', 'test/unit/watch']

gulp.task 'watch/dev', ['build/dev'], ->
  gulp.watch ['app/**/*.coffee', '!app/**/*Spec.coffee', 'config/dev.coffee'], ['build/dev/js', 'build/dev/index.html', reload]
  gulp.watch ['app/**/*.scss'], ['build/dev/css', ->]
  gulp.watch ['app/**/*.html', '!index.html'], ['build/dev/templates', reload]
  gulp.watch ['app/index.html'], ['build/dev/index.html', reload]

  # Watch for added and deleted files (only sass and coffee files)
  gulp.watch ['app/**/*.coffee', 'app/**/*.scss', 'bower_components/**/*.js', '!app/**/*Spec.coffee'], (event) ->
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


gulp.task 'watch/test', ['build/test/unit'], ->
  # Watch for and rebuild modified test files. No need to reload, as Karma
  # does that itself
  gulp.watch ['app/**/*Spec.coffee'], ['build/test/unit/specs']

  # Delete deleted test files. Again, Karma watches and reloads itself, so
  # deleting the source file is sufficient
  gulp.watch ['app/**/*Spec.coffee'], (event) ->
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
