import wollok.game.*
import personaje.*

object caja{
	var property position = game.at(2,1)
	var property image = "cajaMadera.jpg"

	method moverDerecha() {
		position = position.right(1)
	}
	
	method moverIzquierda(){
		position = position.left(1)
	}
	
	method rebotarContra(){
		game.onCollideDo(self,{chocado => chocado.rebotar()})
	}
	
	method muere(){
		game.clear()
		game.addVisual(fin)
	}
	
	method tocarBoton(){
		self.moverIzquierda()
		self.image("cajaMovida.png")
		boton.image("botonApretado.png")
		personaje.rebotar()
		//game.removeVisual(self)
		//game.addVisual(cajaInamovible)
		//game.onCollideDo(cajaInamovible,{chocado => chocado.rebotar()})
		//cajaInamovible.rebotarContra()
		if (!game.hasVisual(escaleraAbajo)){
			game.addVisual(escaleraAbajo)
			game.onCollideDo(escaleraAbajo,{chocado => chocado.subirEscalera()})
		}	
		
	}
}

object boton{
	var property position = game.at(24,1)
	var property image = "boton.png"
	/*
	method interactuarConCaja(){
		game.say(personaje,"hola")
		self.image("botonApretado.png")
		caja.image("cajaMovida.png")
		caja.moverIzquierda()
		personaje.izquierda()
		if (!game.hasVisual(escaleraAbajo)){
			game.addVisual(escaleraAbajo)
			game.onCollideDo(escaleraAbajo,{chocado => chocado.subirEscalera()})
		}	
	}
	*/
}

object bandera{
	var property position = game.at(20,3)	
	var property image = "banderaFin.png"
	
	method ganaste(){
		game.addVisual(ganaste)
	}
}

object ganaste{
	var property position = game.origin()
	var property image = "ganaste.png"
}

object escaleraAbajo{
	var property position = game.at(4,1)	
	var property image = "escalera.png"
}

object escaleraDoble{
	var property position = game.at(4,2)
	var property image = "escaleraDoble.png"
}
