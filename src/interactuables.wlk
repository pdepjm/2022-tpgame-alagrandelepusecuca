import wollok.game.*
import personaje.*
import obstaculos.*
import extras.*


class Objeto{
	var property position
	var property image
	
	method guardar(){}
	method usar(){}
}

class ObjetoUsable inherits Objeto{
	override method guardar(){
		game.removeVisual(self)
		personaje.primerSlotLibre().llenarSlot(self)
	}
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

object bandera inherits Objeto(position = game.at(20,3),image = "banderaFin.png"){	
	method ganador(){
		game.clear()
		game.addVisual(ganaste)
	}
}

const boton = new Objeto(position =game.at(24,1),image = "boton.png")


const escaleraAbajo = new Objeto(position = game.at(4,1),image = "escalera.png")


// Objetos que pueden ir al inventario:
object kit inherits ObjetoUsable(position = game.at(18,3), image = "kit.png"){
	
	method imagenIzq() = "jerryKitIzq.png"
	method imagenDer() = "jerryKitDer.png"
		
	method equipar(){
		personaje.image(self.imagenDer())
	}
	
	override method guardar(){
		game.removeVisual(self)
		personaje.primerSlotLibre().llenarSlot(self)
	}
	
	override method usar(){
		if (personaje.objetoEnMano() == self){
			if(personaje.vidasRestantes() < 3)
				personaje.sumarVida()
			game.removeVisual(self)
		}
		personaje.equiparVacio()
	}
}

object espada inherits ObjetoUsable(position = game.at(15,3), image = "espada.png"){
	method imagenDer() = "morty.png"
	method imagenIzq() = "jerryKitIzq.png"
	
	method equipar(){
		personaje.image(self.imagenDer())
	}
	
	override method usar(){
		if (personaje.objetoEnMano() == self){
			game.say(personaje,"te mato")
			game.removeVisual(self)
		}
		personaje.equiparVacio()
	}
}



