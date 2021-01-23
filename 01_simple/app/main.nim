import asynchttpserver, asyncdispatch

var server = newAsyncHttpServer()

proc callback(req: Request) {.async.} =
  await req.respond(Http200, "Hello Nim")

waitFor server.serve(Port(1234), callback)
