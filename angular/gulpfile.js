var gulp = require('gulp');
var webpack = require('webpack-stream');
var templateCache = require('gulp-angular-templatecache');
var browserSync = require('browser-sync');

gulp.task('templates', function() {
  return gulp.src('app/templates/**/*.html')
    .pipe(templateCache({
      moduleSystem: 'browserify',
      templateHeader: 'function($templateCache) {\n',
      templateFooter: '\n}\nmodule.exports.$inject = ["$templateCache"];'
    }))
    .pipe(gulp.dest('app'));
});

gulp.task('webpack', ['templates'], function() {
  return gulp.src('app/app.js.coffee')
    .pipe(webpack(require('./webpack.config.js')))
    .pipe(gulp.dest('build/'));
});

gulp.task('serve', function() {
  browserSync.init({
    server: {
      baseDir: './build'
    },
    port: '8888'
  })
});

gulp.task('dev', ['templates', 'webpack', 'serve']);
