import wollok.game.*
import interactuables.*
import extras.*

const corazon1 = new Corazon(position = game.at(0,14))
const corazon2 = new Corazon(position = game.at(1,14))
const corazon3 = new Corazon(position = game.at(2,14),image = "corazonVacio.png")

const pos1 = new Slot(position = game.at(10,14))
const pos2 = new Slot(position = game.at(11,14))
const pos3 = new Slot(position = game.at(12,14))
const pos4 = new Slot(position = game.at(13,14))
const pos5 = new Slot(position = game.at(14,14))

object personaje {
	var property posicionReaparicion = game.at(0,4)
	var property position = posicionReaparicion
	var property anterior
	var property image = "movimiento/jerryDer.png"
	
	var property direccion = derecha
	
	const corazones = [corazon3,corazon2,corazon1]

	const property inventario = [pos1,pos2,pos3,pos4,pos5]
	var property objetoEnMano = vacio
	
	method tocarBoton(){
		game.say(self, "Usar Caja")
	}
	
	 	
 	// Inventario
 	method objetoEnPos(n) = inventario.get(n).objetoGuardado()
 	
 	method equiparVacio(){
 		self.objetoEnMano(vacio)
		vacio.equipar(direccion)
 	}
 	method equiparObjeto(pos){
	 	if (objetoEnMano == self.objetoEnPos(pos)){
	 		self.equiparVacio()
	 	}else{
	 		if (!inventario.get(pos).vacio() and objetoEnMano != self.objetoEnPos(pos)){
		 		objetoEnMano = self.objetoEnPos(pos)
		 		objetoEnMano.equipar(direccion)
		 		objetoEnMano.posicion(pos)
	 		}
 		}
 	}
 	method primerSlotLibre() = inventario.find({marco => marco.vacio()})
 	
 	// Movimiento:
	method rebotar(){
		position = anterior
	}
	method izquierda() {
		direccion = izquierda
		objetoEnMano.equipar(direccion)
		anterior = position
		position = position.left(1)
	}
	method derecha() {
		direccion = derecha
		objetoEnMano.equipar(direccion)
		anterior = position
		position = position.right(1)
	}	
	method arriba(n){
		anterior = position
		position = position.up(n)
	}
	method subirEscalera(n){
		self.arriba(n)
	}
	method agacharse(){
		if (objetoEnMano == agachado){
			self.equiparVacio()
	 	}else{
			objetoEnMano = agachado
	 		image = direccion.imagen(objetoEnMano)
			}
 		}

	method disparar(){
		self.crearFuego()
		game.onTick(2000,"DisparoFuego",{self.crearFuego()})
	}
	method crearFuego(){
		const fueguito = new FuegoBala()
		game.addVisual(fueguito)
		game.onTick(1000,"DisparoFuego",{fueguito.moverse()})
	}

	method ganaste(){
 		game.clear()
		game.schedule(350,{game.addVisual(ganaste)})
 	}
		
	
	// Vidas:
	method muere(){
		if(self.vidasRestantes() == 1){
			game.clear()
			game.schedule(350,{game.addVisual(fin)})
		}
		else
			self.restarVida()
		position = posicionReaparicion
		image = "movimiento/jerryDer.png"
		objetoEnMano = vacio
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

// Objetos de posicion
object derecha{
	method imagen(objeto) = objeto.imagenDer()
}

object izquierda{
	method imagen(objeto) = objeto.imagenIzq()
}

object agachado{
	method imagenIzq() = "movimiento/jerryAcostadoIzq.png"
	method imagenDer() = "movimiento/jerryAcostadoDer.png"
	
	method equipar(direccion){
		personaje.objetoEnMano(self)
		personaje.image(direccion.imagen(self))
	}
	
	method usar(){
		game.say(personaje,"No tengo \n nada equipado.")
	}
}

// Inventario:
class Slot{
	var property position
	var property image = "bloques/marcoInventario.png"
	var property objetoGuardado = null
	
	method vacio() = objetoGuardado == null
	
	method llenarSlot(objeto){
		game.addVisual(objeto)
		objeto.position(self.position())
		objetoGuardado = objeto
	}
	method vaciarSlot(){
		objetoGuardado = null
	}
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

object vacio{
	method imagenIzq() = "movimiento/jerryIzq.png"
	method imagenDer() = "movimiento/jerryDer.png"
	
	method equipar(direccion){
		personaje.objetoEnMano(self)
		personaje.image(direccion.imagen(self))
	}
	
	method usar(){
		game.say(personaje,"No tengo \n nada equipado.")
	}
}

