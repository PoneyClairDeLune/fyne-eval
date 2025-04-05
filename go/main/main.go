package main

import (
	"fmt"
	"time"

	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/widget"
	"fyne.io/fyne/v2/container"
)

func main() {
	var fyneApp fyne.App = app.New()
	var testWindow fyne.Window = fyneApp.NewWindow("Hi Luna!")
	var testLabel *widget.Label = widget.NewLabel("Luna is the best princess.")
	testWindow.SetContent(container.NewVBox(testLabel, widget.NewLabel("The deer is always horny.")))
	go func() {
		for range time.Tick(time.Second) {
			testLabel.SetText(time.Now().Format("Deer nommed at 03:04:05"))
		}
	} ()
	testWindow.Show()
	var testWindow2 fyne.Window = fyneApp.NewWindow("Deer's property")
	var testLabel2 *widget.Label = widget.NewLabel("Very horny!")
	testWindow2.SetContent(testLabel2)
	testWindow2.Resize(fyne.NewSize(514, 114))
	testWindow2.Show()
	fyneApp.Run()
	destructor()
}

func destructor() {
	fmt.Println("The deer is always happy.")
}
