var Promise      = require('es6-promise').Promise;
var gulp         = require('gulp');
var browserSync  = require('browser-sync').create();
var sass         = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');

// Create `dev` command, wrapping up tasks into a nice package
gulp.task('dev', ['sass'], function() {

  browserSync.init({
    proxy: 'yoursite.dev' // match Craft's port
  });

  // Watch for changes and then reload
  gulp.watch("./public/scss/**/*.scss", ['sass']);
  gulp.watch(["./craft/templates/**/*.html", "./public/js/**/*.js"]).on('change', browserSync.reload);
});

// Map default task to `dev`
gulp.task('default', ['dev']);

// Compile once without watching
gulp.task('compile', ['sass']);

// Subtasks:
// ----------

// Compile sass into CSS & trigger browser reload
gulp.task('sass', function() {
  return gulp.src("./public/scss/**/*.scss")
    .pipe(sass({ outputStyle: 'expanded' }).on('error', sass.logError))
    .pipe(autoprefixer({
      browsers: ['last 2 versions'],
      cascade: true
    }))
    .pipe(gulp.dest("./public/css"))
    .pipe(browserSync.stream());
});