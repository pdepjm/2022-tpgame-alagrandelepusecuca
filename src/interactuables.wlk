import wollok.game.*
import personaje.*

object caja{
	var position = game.at(2,1)
	var imagen = "cajaMadera.jpg"
	method position() = position
	method image() = imagen
	method moverADerecha() {
		position = position.right(1)
	}
	
	method moverIzquierda(){
		position = position.left(1)
	}
		
	method tocarBoton(){
		boton.interactuoCaja()
		personaje.izquierda()
		imagen = "cajaMovida.png"
		game.addVisual(escaleraAbajo)
		self.moverIzquierda()		
	}
	
	method muere(){
		game.say(personaje, "RIP \n Fin del juego.\n \n \n \n")
	}
}


object boton{
	var property position = game.at(24,1)
	var imagen = "boton.png"
	
	method image() = imagen
	method interactuoCaja(){
		imagen = "botonApretado.png"
	}
}

object escaleraAbajo{
	var property position = game.origin().right(4).up(1)	
	method image() = "escalera.png"
}

object escaleraMedio{
	var property position = game.origin().right(4).up(2)
	 
	method image() = "escalera.png"
}

object escaleraArriba{
	var property position = game.origin().right(4).up(3)
	 
	method image() = "escalera.png"
}
