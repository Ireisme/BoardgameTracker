var fs = require('fs');
var gulp = require('gulp');

/**
 *  This will load all js or coffee files in the gulp directory
 *  in order to load all gulp tasks
 */
fs.readdirSync('./gulp').filter(function(file) {
  return (/\.(js|coffee)$/i).test(file);
}).map(function(file) {
  require('./gulp/' + file);
});

gulp.task('serve:full-stack', ['rails', 'client']);

gulp.task('default', ['serve:full-stack']);

gulp.task('heroku:production', ['views', 'webpack', 'styles']);
