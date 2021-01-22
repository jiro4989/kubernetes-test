package main

import (
  "os"
  "io/ioutil"
  "strconv"
  "fmt"
  "net/http"
)

var (
  internalAPIHost string
  internalAPIPort string
)

func handler(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "Hello, World")

  b, err := ioutil.ReadFile("/etc/app/config.json")
  if err != nil {
    panic(err)
  }
  fmt.Fprintf(w, string(b))

  resp, err := http.Get(internalAPIHost + ":" + internalAPIPort)
  if err != nil {
    panic(err)
  }
  defer resp.Body.Close()

  b, err = ioutil.ReadAll(resp.Body)
  if err != nil {
    panic(err)
  }
  fmt.Fprintf(w, string(b))
}

func main() {
  port := os.Getenv("SERVER_PORT")

  // validation
  _, err := strconv.Atoi(port)
  if err != nil {
    panic(err)
  }

  // validation
  internalAPIHost = os.Getenv("INTERNAL_API_HOST")
  if internalAPIHost == "" {
    panic("'INTERNAL_API_HOST' must be set")
  }

  // validation
  inPort = os.Getenv("INTERNAL_API_PORT")
  _, err := strconv.Atoi(inPort)
  if err != nil {
    panic(err)
  }
  internalAPIPort = inPort

  http.HandleFunc("/", handler)
  http.ListenAndServe(":" + port, nil)
}