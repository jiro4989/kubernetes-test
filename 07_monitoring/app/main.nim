import asynchttpserver, asyncdispatch, httpclient
from strutils import parseInt
from os import getEnv
from strformat import `&`

let
  port = getEnv("SERVER_PORT").parseInt
  inHost = getEnv("INTERNAL_API_HOST")
  inPort = getEnv("INTERNAL_API_PORT").parseInt
  client = newHttpClient()

var
  server = newAsyncHttpServer()

proc callback(req: Request) {.async.} =
  let data = readFile("/etc/app/config.json")
  {.gcsafe.}:
    let cont = client.getContent(&"{inHost}:{inPort}")
  await req.respond(Http200, "Hello Nim and skaffold\n" & data & cont)

waitFor server.serve(Port(port), callback)
