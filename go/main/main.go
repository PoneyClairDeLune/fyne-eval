package main

import (
	"fmt"
	"time"

	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/widget"
)

func main() {
	var fyneApp fyne.App = app.New()
	var testWindow fyne.Window = fyneApp.NewWindow("Hi Luna!")
	var testLabel *widget.Label = widget.NewLabel("Luna is the best princess.")
	testWindow.SetContent(testLabel)
	go func() {
		for range time.Tick(time.Second) {
			testLabel.SetText(time.Now().Format("Deer nommed at 03:04:05"))
		}
	} ()
	testWindow.Show()
	fyneApp.Run()
	destructor()
}

func destructor() {
	fmt.Println("The deer is always happy.")
}
