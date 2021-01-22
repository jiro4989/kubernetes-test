package main

import (
  "os"
  "io/ioutil"
  "strconv"
  "fmt"
  "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "Hello, World")

  b, err := ioutil.ReadFile("/app/data.json")
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

  http.HandleFunc("/", handler)
  http.ListenAndServe(":" + port, nil)
}