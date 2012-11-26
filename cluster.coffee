os = require 'os'
cluster = require 'cluster'

cluster.setupMaster
  exec: "app.coffee"
if cluster.isMaster
  os.cpus().forEach ()->
    cluster.fork()
  cluster.on "exit", (worker)->
    exitCode = worker.process.exitCode
    console.log "worker #{worker.process.pid} died because of #{exitCode}. starting back up."
    cluster.fork()

cluster.on "online", (worker)->
  console.log "created new worker at pid #{worker.process.pid}"