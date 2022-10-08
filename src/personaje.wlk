import wollok.game.*
import interactuables.*

object personaje {
	var position = game.origin().up(1)
	var anterior 
	
	method image() = "Jerry.png"
	
	method moverCaja(){
		game.onCollideDo(caja,{chocado => caja.moverADerecha()})
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
		game.say(self, "RIP \n Fin del juego.\n \n \n \n")
	}	
}

