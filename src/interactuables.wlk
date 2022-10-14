import wollok.game.*
import personaje.*
import obstaculos.*
import extras.*


class Objeto{
	var property position
	var property image
	
	method interactuar(){}
	method usar(){}
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
	
	override method interactuar(){
		self.moverDerecha()
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

object bandera inherits Objeto(position = game.at(24,3),image = "banderaFin.png"){	
	method ganador(){
		game.clear()
		game.addVisual(ganaste)
	}
}

const boton = new Objeto(position =game.at(24,1),image = "boton.png")


const escaleraAbajo = new Objeto(position = game.at(4,1),image = "escalera.png")

class ObjetoUsable inherits Objeto{
	var property posicion = null
	
	method imagenDer()
	
	override method interactuar(){
		// En realidad lo guarda
		game.removeVisual(self)
		personaje.primerSlotLibre().llenarSlot(self)
	}
	method equipar(direccion){
		personaje.image(direccion.imagen(self))
	}
	method tirarObjeto(){
		game.removeVisual(self)
		personaje.equiparVacio()
		personaje.inventario().get(posicion).vaciarSlot()
		personaje.image(personaje.direccion().imagen(vacio))
	}
}

// Objetos que pueden ir al inventario:
// Deberian entender imagenIzq(), imagenDer() y usar()
object kit inherits ObjetoUsable(position = game.at(18,3), image = "kit.png"){
	
	method imagenIzq() = "jerryKitIzq.png"
	override method imagenDer() = "jerryKitDer.png"
	
	override method usar(){
		if (personaje.objetoEnMano() == self){
			if(personaje.vidasRestantes() < 3)
				personaje.sumarVida()
			self.tirarObjeto()
		}
	}
}

object espada inherits ObjetoUsable(position = game.at(15,3), image = "espada.png"){
	method imagenIzq() = "espadaEnUsoIzq.png"
	override method imagenDer() = "espadaEnUsoDer.png"
}



