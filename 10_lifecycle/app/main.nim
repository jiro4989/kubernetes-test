import asynchttpserver, asyncdispatch, httpclient
from strutils import parseInt
from os import getEnv
from strformat import `&`
import json

# 外部ライブラリ
import jester

let
  port = getEnv("SERVER_PORT").parseInt.Port
  inHost = getEnv("INTERNAL_API_HOST")
  inPort = getEnv("INTERNAL_API_PORT").parseInt
  client = newHttpClient()

router myrouter:
  get "/":
    let data = readFile("/etc/app/config.json")
    {.gcsafe.}:
      let content = client.getContent(&"{inHost}:{inPort}")
    resp %*{
      "content": content,
      "data": data,
    }
  get "/healthz":
    resp %*{
      "status": "ok",
    }

var serverSettings = newSettings(port = port)
var server = initJester(myrouter, settings = serverSettings)
server.serve()
