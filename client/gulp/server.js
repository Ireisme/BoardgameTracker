var gulp = require('gulp');
var spawn = require('child_process').spawn;

gulp.task('rails', function() {
  var options = { cwd: '..' };
  const rails = spawn('rails', ['server'], options);

  rails.stdout.on('data', (data) => {
    console.log(`stdout: ${data}`);
  });

  rails.stderr.on('data', (data) => {
    console.log(`stderr: ${data}`);
  });

  rails.on('close', (code) => {
    console.log(`child process exited with code ${code}`);
  });

  rails.on('error', (err) => {
    console.log('Failed to start child process. ' + err);
  });
})
