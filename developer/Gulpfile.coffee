gulp = require 'gulp'
imagemin = require 'gulp-imagemin'
pngquant = require 'imagemin-pngquant'
spritesmith = require 'gulp.spritesmith'
minifycss = require 'gulp-minify-css'
concat = require 'gulp-concat'
autoprefixer = require 'gulp-autoprefixer'
uglify = require 'gulp-uglify'
stylus = require 'gulp-stylus'
rename = require 'gulp-rename'
watch = require 'gulp-watch'
coffee = require 'gulp-coffee'

src = '../resources/assets/'

gulp.task 'pngmin', ->
  spriteData = gulp.src './images/sprites/**/*.png'
  .pipe spritesmith({
    imgName: '../images/sprite.png',
    cssName: 'sprite.styl'
  })
  spriteData.img
  .pipe imagemin({
    use: [pngquant()]
  })
  .pipe gulp.dest src + 'images'
  spriteData.css
#  .pipe minifycss()
  .pipe gulp.dest 'stylus/'


# Concat Vendors JS and CSS files
gulp.task 'vendors', ->
  gulp.src [
    'vendors/jquery/dist/jquery.js'
  ]
  .pipe concat('vendors.min.js')
  .pipe uglify()
  .pipe gulp.dest src + 'js/'

  gulp.src [
    ''
  ]
  .pipe concat('vendors.min.css')
  .pipe minifycss {
    'keepSpecialComments' : 0
  }
  .pipe gulp.dest src + 'css/'


# Make STYLUS to CSS, and minify css
gulp.task 'stylus', ->
  gulp.src 'stylus/main.styl'
  .pipe stylus {
    'include css': true
  }
#  .pipe minifycss {
#    'keepSpecialComments' : 0
#  }
  .pipe rename {
    suffix: '.min'
  }
  .pipe gulp.dest src + 'css/'

gulp.task 'coffee', ->
  gulp.src 'coffee/app.coffee'
  .pipe coffee()
  .pipe rename {
    suffix: '.min'
  }
  .pipe gulp.dest src + 'js/'

gulp.task 'watch', ->
  gulp.watch 'stylus/*.styl', ['stylus']
  gulp.watch 'coffee/app.coffee', ['coffee']

gulp.task 'default'