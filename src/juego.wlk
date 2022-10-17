import wollok.game.*
import personaje.*
import obstaculos.*
import interactuables.*
import extras.*
import enemigos.*

object juego{
	var property nivelActual = nivel0

	method iniciar(){
		self.configurarJuego()
		self.agregarInventario()
		self.configurarPersonaje()
		self.interaccionesGenerales()
		nivelActual.iniciar()
		game.start()	
	}

	method siguienteNivel(){
		nivelActual = nivelActual.proximoNivel()
		nivelActual.iniciar()
	}

	method interaccionesGenerales(){
		game.onCollideDo(personaje,{chocado => chocado.interactuar()})
	}

	method configurarJuego(){
		game.title("Las aventuras de Jerry")
		game.width(25)
		game.height(15)
		game.boardGround("fondo.jpg")	
	}
	
	method configurarPersonaje(){
		game.addVisual(personaje)
		
		// Movimientos:
		keyboard.left().onPressDo({personaje.izquierda()})
		keyboard.right().onPressDo({personaje.derecha()})
		keyboard.control().onPressDo({personaje.agacharse()})
		
		// Inventario:
		keyboard.space().onPressDo({personaje.objetoEnMano().usar()})
		keyboard.num1().onPressDo({personaje.equiparObjeto(0)})
		keyboard.num2().onPressDo({personaje.equiparObjeto(1)})
		keyboard.num3().onPressDo({personaje.equiparObjeto(2)})
		keyboard.num4().onPressDo({personaje.equiparObjeto(3)})
		keyboard.num5().onPressDo({personaje.equiparObjeto(4)})
		
		// Vidas:
		game.addVisual(corazon1)
		game.addVisual(corazon2)
		game.addVisual(corazon3)
	}
	method agregarInventario(){
		game.addVisual(pos1)
		game.addVisual(pos2)
		game.addVisual(pos3)
		game.addVisual(pos4)
		game.addVisual(pos5)
	}
}



class Nivel {
	method proximoNivel() = null
	
	// Metodos abstractos:	
	method agregarObstaculos()
	method iniciar()

	method agregarEnemigos(){}
	method agregarObjetos(){}
	method interacciones(){}

	
	// Metodos para agregar obstaculos
	method nuevoBloque(posicion,imagen){
		const bloque = new Bloque(position = posicion,image = imagen)
		game.addVisual(bloque)
		bloque.noDejaPasar()
	}
	method nuevoObjeto(posicion,imagen){
		const objeto = new Objeto(position = posicion,image = imagen)
		game.addVisual(objeto)
	}
	method nuevoFuego(posicion){
		const fuego = new Fuego(position = posicion,image = "fuego.png")
		fuego.fuegoIntermitente()
	}
	method nuevaEscaleraTriple(posicion){
		const escalera = new Escalera(position = posicion)
		game.addVisual(escalera)
		escalera.escalable()
	}
}


object nivel0 inherits Nivel {
	override method iniciar(){
		self.agregarObjetos()
		self.agregarObstaculos()
		self.interacciones()
	}

	override method agregarObstaculos(){
		game.width().times{col=> 
			if (col != 5)
				self.nuevoBloque(game.at(col-1,2),"piedra.jpg")}
		
		game.width().times{col=> 
			self.nuevoBloque(game.at(col-1,0),"tierra.png")}
		
		self.nuevoFuego(game.at(8,3))
		game.schedule(350,{self.nuevoFuego(game.at(12,3))})
		
	}
	
	override method agregarObjetos(){
		game.addVisual(caja)
		game.addVisual(boton)
		game.addVisual(banderaRoja1)
		game.addVisual(kit)
		game.addVisual(espada)
		self.nuevoObjeto(game.at(4,2),"escaleraDoble.png")
		
	}
	
	override method interacciones(){
		game.onCollideDo(boton,{chocado => chocado.tocarBoton()})
	}	

	override method proximoNivel() = nivel1
}

object nivel1 inherits Nivel {
	override method iniciar(){
		self.agregarObstaculos()
		self.agregarObjetos()
		self.agregarEnemigos()
		game.removeVisual(personaje)
		game.addVisual(personaje)
	}

	override method agregarObjetos(){
		self.nuevaEscaleraTriple(game.at(22,3))
	}

	override method agregarObstaculos(){
		game.width().times{col=> 
			if (col != 23)
				self.nuevoBloque(game.at(col-1,4),"piedra.jpg")}
	}
			
	method agregarEnemigos(){
		game.addVisual(caballero)
	}
}