var gulp = require('gulp');
var webpack = require('webpack-stream');
var templateCache = require('gulp-angular-templatecache');
var browserSync = require('browser-sync');
var path = require('path');
var conf = require('./conf');

function browserSyncInit(baseDir, browser) {
  browser = browser === undefined ? 'default' : browser;

  var server = {
    baseDir: baseDir
  };

  browserSync.instance = browserSync.init({
    server: server,
    browser: browser,
    port: conf.ports.client
  });
}

gulp.task('views', function() {
  gulp.src(['index.html'])
  .pipe(gulp.dest(conf.clientPaths.build))

  return gulp.src(path.join(conf.clientPaths.app, 'templates/**/*.html'))
    .pipe(templateCache({
      moduleSystem: 'browserify',
      templateHeader: 'function($templateCache) {\n',
      templateFooter: '\n}\nmodule.exports.$inject = ["$templateCache"];'
    }))
    .pipe(gulp.dest(conf.clientPaths.app));
});

gulp.task('webpack', ['views'], function() {
  return gulp.src(path.join(conf.clientPaths.app, 'app.js.coffee'))
    .pipe(webpack(require('../webpack.config.js')))
    .pipe(gulp.dest(path.join(conf.clientPaths.build, 'js/')));
});

gulp.task('styles', function() {
return gulp.src('css/**/*.css')
    .pipe(gulp.dest(path.join(conf.clientPaths.build, 'css/')));
});

gulp.task('serve', function() {
  browserSyncInit('./' + conf.clientPaths.build, []);
});

gulp.task('client', ['views', 'webpack', 'styles', 'serve']);
