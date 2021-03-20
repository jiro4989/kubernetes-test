import asynchttpserver, asyncdispatch, db_mysql
from strutils import parseInt
from os import getEnv

var
  server = newAsyncHttpServer()

let
  host = getEnv("DB_HOST")
  user = getEnv("DB_USER")
  password = getEnv("DB_PASSWORD")
  dbName = getEnv("DB_NAME")

proc callback(req: Request) {.async.} =
  {.gcsafe.}:
    let db = open(host, user, password, dbName)
  let rows = db.getAllRows(sql"SELECT id, name, email FROM users")
  defer: db.close
  await req.respond(Http200, "Hello Nim internal and skaffold" & $rows)

let port = getEnv("SERVER_PORT").parseInt
waitFor server.serve(Port(port), callback)
