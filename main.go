package main

import (
	"graphics.gd/classdb"
	"graphics.gd/startup"
)

func main() {
	classdb.Register[Dungeoner]()
	startup.Scene()
}
