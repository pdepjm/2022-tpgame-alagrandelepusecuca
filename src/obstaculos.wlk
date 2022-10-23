import wollok.game.*
import personaje.*
import interactuables.*

class Bloque inherits Objeto{
}

class Fuego inherits Objeto{
	method fuegoIntermitente(){
		game.addVisual(self)
		game.onTick(2500,"Aparece",{self.titila()})
	}
	
	method titila(){
		if(game.hasVisual(self))
			game.removeVisual(self)
		else{
			game.addVisual(self)
		}
	}

	override method interactuar(){
		personaje.muere()
	}
}
 
class Pinche inherits Objeto(image = "pinches/pincheBajo.png"){
	
	method pincheIntermitente(){
		game.onTick(2500,"Cambiar Estado",{self.cambiarEstado()})
	}
	method cambiarEstado(){
		if (!self.estaArriba()){
			game.addVisual(self)
			self.subirPinche()
		}
		else
			self.bajarPinche()
	}

	method titila(){
		if(game.hasVisual(self))
			game.removeVisual(self)
		else{
			game.addVisual(self)
		}
	}

	method interactuar(){
		personaje.muere()
	}
	
	method estaArriba() = image == "pinches/pincheAlto.png"

	method bajarPinche(){
		game.schedule(350,{image ="pinches/pincheMedio.png"})
		game.schedule(700,{image ="pinches/pincheBajo.png"})
		game.schedule(1000,{game.removeVisual(self)})

	}
	method subirPinche(){
		game.schedule(350,{image ="pinches/pincheMedio.png"})
		game.schedule(700,{image ="pinches/pincheAlto.png"})
	}
}