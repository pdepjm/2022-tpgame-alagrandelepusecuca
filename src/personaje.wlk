import wollok.game.*
import interactuables.*

object personaje {
	var property position = game.at(0,1)
	var anterior
	var property image = "jerryDer.png"
	
	method interactuarConCaja(){
		caja.moverDerecha()
	}	
 
	method rebotar(){
		position = anterior
	}
	
	method izquierda() {
		self.image("jerryIzq.png")
		anterior = position
		position = position.left(1)
	}
	method derecha() {
		self.image("jerryDer.png")
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
		game.schedule(350,{game.addVisual(fin)})
	}	
	
}

object fin inherits Objeto(position = game.origin(), image = "fin.png"){
}