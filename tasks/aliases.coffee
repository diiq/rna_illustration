gulp = require('gulp')

# Build absolutely everything (not sure why you would want to, but here it is)
gulp.task 'build', ['build/dev', 'build/dist', 'build/test/unit', 'build/test/e2e']

# Build the development site
gulp.task 'build/dev', ['build/dev/index.html', 'build/dev/js', 'build/dev/templates', 'build/dev/css', 'build/dev/bower', 'build/dev/images']

# Build the tests and test dependencies
gulp.task 'build/test', ['build/test/unit', 'build/test/e2e']

# Run all the tests and exit
gulp.task 'test', ['test/unit', 'test/e2e', 'lint']

# Run tests against dist
gulp.task 'test/dist', ['test/dist/unit', 'test/dist/e2e']

# Run the dev server and test runner, in debug mode
gulp.task 'test/unit/debug', ['server/dev','build/dev', 'watch', 'test/unit/debug']

# Just dist stuff
gulp.task 'dist', ['build/dist', 'server/dist']

# Run the dev server and test runner while watching for changes
gulp.task 'default', ['build/dev', 'server/dev', 'watch']
