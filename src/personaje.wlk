import wollok.game.*
import interactuables.*

object personaje {
	var position = game.at(0,1)
	var anterior 
	
	method image() = "Jerry.png"
	
	method interactuarConCaja(){
		caja.moverDerecha()
	}	
	method position() = position 
	method rebotar(){
		position = anterior
	}
	
	method izquierda() {
		anterior = position
		position = position.left(1)
	}
	method derecha() {
		anterior = position
		position = position.right(1)
	}
	
	method arriba(n) {
		anterior = position
		position = position.up(n)
	}
	
	method subirEscalera(){
		self.arriba(2)
	}
	
	method muere(){
		game.clear()
		game.addVisual(fin)
	}	
}

object fin{
	var property position = game.origin()
	var property image = "fin.png"
}
