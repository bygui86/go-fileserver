package main

import (
	"log"
	"net/http"
)

// MISSING METRICS
// MISSING KUBE PROBES

func main() {

	fs := http.FileServer(http.Dir("html"))
	http.Handle("/", fs)

	log.Println("Listening...")
	http.ListenAndServe(":8080", nil)
}
