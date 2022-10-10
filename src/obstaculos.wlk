import wollok.game.*
import personaje.*

class Obstaculo{
	var property position
	var property image
}

class Fuego inherits Obstaculo{
	method fuegoIntermitente(){
		game.addVisual(self)
		game.onCollideDo(self,{chocado => chocado.muere()})
		game.onTick(2500,"Aparece",{self.titila()})
	}
	
	method titila(){
		if(game.hasVisual(self))
			game.removeVisual(self)
		else{
			game.addVisual(self)
			game.onCollideDo(self,{chocado => chocado.muere()})
		}
	}
}