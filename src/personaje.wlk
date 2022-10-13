import wollok.game.*
import interactuables.*
import extras.*

const corazon1 = new Corazon(position = game.at(0,14))
const corazon2 = new Corazon(position = game.at(1,14))
const corazon3 = new Corazon(position = game.at(2,14))

object personaje {
	var property position = game.at(0,3)
	var anterior
	var property image = "jerryDer.png"
	
	const corazones = [corazon3,corazon2,corazon1]
	
	// Interacciones	
	method interactuarConCaja(){
		caja.moverDerecha()
	}	
 	
 	
 	// Movimiento:
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
	
	method arriba() {
		anterior = position
		position = position.up(1)
	}	
	
	method subirEscalera(){
		self.arriba()
		self.arriba()
	}
	
	
	// Vidas:
	method muere(){
		if(self.vidasRestantes() <= 1){
			game.clear()
			game.schedule(350,{game.addVisual(fin)})
		}
		else
			self.restarVida()
	}	
	
	method usarKit(){
		if(self.vidasRestantes() < 3)
			self.sumarVida()
		game.removeVisual(kit)
	}
	
	method sumarVida(){
		self.ultimoCoraVacio().llenarCorazon()
	}
	
	method restarVida(){
		self.primerCoraLLeno().vaciarCorazon()		
	}
	
	method vidasRestantes() = corazones.filter({cora => cora.lleno()}).size()
	
	
	// Para buscar corazones
	method ultimoCoraVacio() = 
		corazones.filter({cora => cora.image() == "corazonVacio.png"}).last()

	method primerCoraLLeno() = 
		corazones.find({cora => cora.image() == "corazonLLeno.png"})
}


class Corazon{
	var property position
	var property image = "corazonLLeno.png"
	
	method lleno() = image == "corazonLLeno.png"
	
	method vaciarCorazon(){
		self.image("corazonVacio.png")
	}
	
	method llenarCorazon(){
		self.image("corazonLLeno.png")
	}
}

