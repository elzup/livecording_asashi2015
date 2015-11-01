gulp = require 'gulp'
gutil = require 'gulp-util'
stylus = require 'gulp-stylus'
koutoSwiss = require 'kouto-swiss'
autoprefixer = require 'gulp-autoprefixer'

$ = require('gulp-load-plugins')()

# config
# src_dir = './src'
# public_dir = './public'

# NOTE: watch は ./ から始めると新規ファイルを読み込まない
# NOTE: /**/*.ext 再帰的マッチ
# config:
#    source: './source/path'
#    watch: 'source/path/*.ext'
#    destination: './output/path'
config =
  jade:
    source: './src/jade'
    watch: 'src/jade/*.jade'
    destination: './public'
    config:
      pretty: true
  coffee:
    source: './src/coffee'
    watch: 'src/coffee/*.coffee'
    destination: './public/js'
    option:
      bare: true
  stylus:
    source: './src/stylus'
    watch: 'src/stylus/**/*.styl'
    destination: './public/css'
# error handle
handleError = (err) ->
  gutil.log err
  gutil.beep()
  this.emit 'end'

# tasks
# tasks jade
gulp.task 'jade', ->
  gulp
    .src config.jade.watch
    .pipe $.jade(
      config.jade.option
    )
    .on 'error', handleError
    .pipe gulp.dest config.jade.destination

# tasks coffee
gulp.task 'coffee', ->
  gulp
    .src config.coffee.watch
    .pipe $.coffee()
    .on 'error', handleError
    .pipe gulp.dest config.coffee.destination

# tasks stylus
gulp.task "stylus", ->
  gulp
    .src config.stylus.watch
    .pipe $.sourcemaps.init()
    .pipe stylus
      compress: true
      use: koutoSwiss()
    .pipe autoprefixer
      browsers: ['last 2 versions']
    .pipe $.sourcemaps.write('.')
    .on 'error', handleError
    .pipe gulp.dest config.stylus.destination

# watch
gulp.task 'watch', ->
  gulp.watch config.coffee.watch, ['coffee']
  gulp.watch config.jade.watch, ['jade']
  gulp.watch config.stylus.watch, ['stylus']

#load
gulp.task 'default', ["coffee", "jade", "stylus"]
