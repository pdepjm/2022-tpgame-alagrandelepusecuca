import wollok.game.*
import personaje.*
import interactuables.*

class Fuego inherits Objeto{
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
			//game.onCollideDo(self,{chocado => chocado.muere()})
		}
	}
}