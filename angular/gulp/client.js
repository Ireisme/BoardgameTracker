var gulp = require('gulp');
var webpack = require('webpack-stream');
var templateCache = require('gulp-angular-templatecache');
var browserSync = require('browser-sync');

function browserSyncInit(baseDir, browser) {
  browser = browser === undefined ? 'default' : browser;

  var server = {
    baseDir: baseDir
  };

  browserSync.instance = browserSync.init({
    server: server,
    browser: browser,
    port: '8888'
  });
}

gulp.task('views', function() {
  gulp.src(['index.html'])
    .pipe(gulp.dest('build/'))

  return gulp.src('app/templates/**/*.html')
    .pipe(templateCache({
      moduleSystem: 'browserify',
      templateHeader: 'function($templateCache) {\n',
      templateFooter: '\n}\nmodule.exports.$inject = ["$templateCache"];'
    }))
    .pipe(gulp.dest('app'));
});

gulp.task('webpack', ['views'], function() {
  return gulp.src('app/app.js.coffee')
    .pipe(webpack(require('../webpack.config.js')))
    .pipe(gulp.dest('build/js/'));
});

gulp.task('styles', function() {
return gulp.src('css/**/*.css')
    .pipe(gulp.dest('build/css/'));
});

gulp.task('serve', function() {
  browserSyncInit('./build', []);
});

gulp.task('client', ['views', 'webpack', 'styles', 'serve']);
