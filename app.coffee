
###
  Module dependencies.
###

express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
sio = require 'socket.io'
redis = require 'redis'
RedisStore = require('socket.io/lib/stores/redis')

pub = redis.createClient()
sub = redis.createClient()
db = redis.createClient()

`app = express()`
server = http.createServer app
io = sio.listen server

io.configure ()->
  io.enable 'browser client minification'  # send minified client
  io.enable 'browser client etag'          # apply etag caching logic based on version number
  io.enable 'browser client gzip'          # gzip the file
  io.set 'log level', 3                    # reduce logging
  io.set 'store', new RedisStore
    redisPub: pub
    redisSub: sub
    redisClient: db

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, 'public'))


app.configure 'development', ->
  app.use express.errorHandler()


app.get '/', routes.index

server.listen app.get('port'), ->
  console.log("Express server listening on port " + app.get('port'))
