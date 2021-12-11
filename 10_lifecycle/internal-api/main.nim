import asynchttpserver, asyncdispatch
from strutils import parseInt
from os import getEnv
import json

# 外部ライブラリ
import jester

let port = getEnv("SERVER_PORT").parseInt.Port

router myrouter:
  get "/":
    resp( % "Internal API")
  get "/healthz":
    resp %*{
      "status": "ok",
    }

var serverSettings = newSettings(port = port)
var server = initJester(myrouter, settings = serverSettings)
server.serve()
