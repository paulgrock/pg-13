
###
  Module dependencies.
###

express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
sio = require 'socket.io'
config = require './config'
redis = require 'redis'
RedisStore = require('socket.io/lib/stores/redis')

pub = redis.createClient(config.redis.port, config.redis.host)
sub = redis.createClient(config.redis.port, config.redis.host)
db = redis.createClient(config.redis.port, config.redis.host)

`app = express()`
server = http.createServer app
io = sio.listen server

db.on "connect", ->
  console.log "connected"

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
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, 'public'))


app.configure 'development', ->
  app.set 'port', process.env.PORT || 3000
  app.use express.errorHandler()


app.configure 'production', ->
  app.set 'port', process.env.PORT || 80
  app.use express.errorHandler()


app.get '/', routes.index

server.listen app.get('port'), ->
  console.log("Express server listening on port " + app.get('port'))
