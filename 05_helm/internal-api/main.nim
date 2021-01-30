import asynchttpserver, asyncdispatch
from strutils import parseInt
from os import getEnv

var server = newAsyncHttpServer()

proc callback(req: Request) {.async.} =
  await req.respond(Http200, "Hello Nim internal")

let port = getEnv("SERVER_PORT").parseInt
waitFor server.serve(Port(port), callback)
