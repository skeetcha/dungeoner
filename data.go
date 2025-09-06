package main

import (
	"fmt"

	"graphics.gd/classdb/Control"
	"graphics.gd/classdb/Label"
	"graphics.gd/classdb/Button"
	"graphics.gd/classdb/SceneTree"
)

type DungeonerStart struct {
	Control.Extension[DungeonerStart]

	Title Label.Instance
	NewGame Button.Instance
	Quit Button.Instance
}

func (ds *DungeonerStart) Ready() {
	ds.NewGame.AsBaseButton().OnPressed(ds.OnNewGamePressed)
	ds.Quit.AsBaseButton().OnPressed(ds.OnQuitPressed)
}

func (ds *DungeonerStart) OnNewGamePressed() {
	fmt.Println("new game")
}

func (ds *DungeonerStart) OnQuitPressed() {
	SceneTree.Get(ds.AsNode()).Quit()
}
