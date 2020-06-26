package main

import "github.com/zserge/webview"

func main() {
	debug := true
	w := webview.New(debug)
	defer w.Destroy()
	w.SetTitle("Gmail")
	w.SetSize(1280, 800, webview.HintNone)
	w.Navigate("https://www.gmail.com/")
	w.Run()
}
