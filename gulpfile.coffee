gulp        = require 'gulp'
mocha       = require 'gulp-mocha'
coffee      = require 'gulp-coffee'
sourcemaps  = require 'gulp-sourcemaps'
through     = require 'through2'
del         = require 'del'

gulp.task 'clean', (done) ->
  del 'lib/**/*', done

gulp.task 'coffee', ->
  gulp
    .src 'src/**/*.coffee'
    .pipe sourcemaps.init()
    .pipe coffee()
    # Only write source maps if env is development. Otherwise just pass thgrough.
    .pipe if process.env.NODE_ENV is 'development' then sourcemaps.write() else through.obj()
    .pipe gulp.dest 'lib/'

gulp.task 'test', ->
  gulp
    .src 'test/*.coffee', read: no
    .pipe mocha
      reporter  : 'spec'
      compilers : 'coffee:coffee-script'
      # TODO: Fix gulp crashing on some errors.
      # They are reported by mocha, but sometimes also passed to the pipeline
      # SEE: http://stackoverflow.com/a/21735066/1151982
      # Below code doesn't work:
      # .on 'error', (error) ->
      #   if watching then return @emit 'end'
      #   else
      #     console.error 'Tests failed'
      #     process.exit 1

gulp.task 'build', gulp.series [
  'clean'
  'coffee'
  'test'
]


gulp.task 'watch', (done) ->
  gulp.watch [
    'test/**/*'
    'package.json'
  ], gulp.series [
    'test'
  ]

  gulp.watch [
    'src/**/*',
  ], gulp.series [
    'build'
  ]

gulp.task 'develop', gulp.series [
  (done) ->
    process.env.NODE_ENV ?= 'development'
    do done
  'build'
  'watch'
]
