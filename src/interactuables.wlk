import wollok.game.*
import personaje.*
import obstaculos.*

class Objeto{
	var property position
	var property image
}

object caja inherits Objeto(position =game.at(2,1),image = "cajaMadera.jpg"){
	method moverDerecha(){
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
		if (!game.hasVisual(escaleraAbajo)){
			game.addVisual(escaleraAbajo)
			game.removeVisual(personaje)
			game.addVisual(personaje)
			game.onCollideDo(escaleraAbajo,{chocado => chocado.subirEscalera()})
		}	
		
	}
}

object boton inherits Objeto(position =game.at(24,1),image = "boton.png"){	
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

object bandera inherits Objeto(position = game.at(20,3),image = "banderaFin.png"){	
	method ganaste(){
		game.clear()
		game.addVisual(ganaste)
	}
}

object ganaste inherits Objeto(position = game.origin(),image = "ganaste.png"){
}

object escaleraAbajo inherits Objeto(position = game.at(4,1),image = "escalera.png"){
}

