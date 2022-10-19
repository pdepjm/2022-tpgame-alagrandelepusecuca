import wollok.game.*
import personaje.*
import enemigos.*
import obstaculos.*
import extras.*
import juego.*


class Objeto{
	var property position
	var property image
	
	method interactuar(){}
	method usar(){}
}


object caja inherits Objeto(position =game.at(2,1),image = "nivel0/cajaMadera.jpg"){
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
		self.image("nivel0/cajaMovida.png")
		boton.image("nivel0/botonApretado.png")
		personaje.rebotar()
		if (!game.hasVisual(escaleraAbajo)){
			game.addVisual(escaleraAbajo)
			game.removeVisual(personaje)
			game.addVisual(personaje)
		}	
		
	}
}

class BanderaRoja inherits Objeto(image = "banderas/banderaBaja.png"){	
	var pasoNivel = false
	override method interactuar(){
		if (!pasoNivel){
			image = "banderas/banderaAlta.png"
			juego.siguienteNivel()
			pasoNivel = true
			personaje.posicionReaparicion(position)
		}
	}
}

const boton = new Objeto(position =game.at(24,1),image = "nivel0/boton.png")

// Escaleras
class Escalera inherits Objeto(image = "escaleras/escaleraCuadruple.png"){
	method interactuar(){
		personaje.subirEscalera(3)
	}
}

const escaleraAbajo = new Escalera(position = game.at(4,1),image = "escaleras/escalera.png")

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
object kit inherits ObjetoUsable(position = game.at(18,4), image = "objetos/kit.png"){
	
	method imagenIzq() = "objetos/jerryKitIzq.png"
	override method imagenDer() = "objetos/jerryKitDer.png"
	
	override method usar(){
		if (personaje.objetoEnMano() == self){
			if(personaje.vidasRestantes() < 3)
				personaje.sumarVida()
			self.tirarObjeto()
		}
	}
}

object espada inherits ObjetoUsable(position = game.at(2,4), image = "objetos/espada.png"){
	method imagenIzq() = "objetos/jerryEspadaIzq.png"
	override method imagenDer() = "objetos/jerryEspadaDer.png"
}

object escudo inherits ObjetoUsable(position = caballero.position().left(1),image = "objetos/escudo.png"){
	method imagenIzq() = "objetos/jerryEscudoIzq.png"
	override method imagenDer() = "objetos/jerryEscudoDer.png"
}
