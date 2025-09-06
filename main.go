package main

import (
	"graphics.gd/classdb"
	"graphics.gd/startup"
)

func main() {
	classdb.Register[DungeonerStart]()
	startup.Scene()
}
