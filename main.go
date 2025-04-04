package main

import (
	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/widget"
)

func main() {
	var fyneApp fyne.App = app.New()
	var testWindow fyne.Window = fyneApp.NewWindow("Hi Luna!")
	testWindow.SetContent(widget.NewLabel("Praise the moon!"))
	testWindow.ShowAndRun()
}
