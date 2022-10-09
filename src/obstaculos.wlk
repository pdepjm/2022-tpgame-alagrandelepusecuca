import wollok.game.*

class Obstaculo{
	var property position
	var property image
}

object fuego{
	var property position = game.at(8,1)
	var property image = "fuego.png"
	
	method fuegoIntermitente(){
		game.onTick(5000,"",{game.removeVisual(fuego)})
		game.onTick(10000,"",{game.addVisual(fuego)})
	}
}