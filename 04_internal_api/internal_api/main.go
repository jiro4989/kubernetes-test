package main

import (
  "os"
  "strconv"
  "fmt"
  "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "Hello, InternalAPI")
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