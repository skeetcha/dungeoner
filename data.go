package main

import (
	"fmt"

	"graphics.gd/classdb/Node"
)

type Dungeoner struct {
	Node.Extension[Dungeoner]
}

func (p *Dungeoner) Ready() {
	fmt.Println("Hello world from Go!")
}
