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
		//self.agregarInventario()
		//self.configurarPersonaje()
		//self.interaccionesGenerales()
		//nivelActual.iniciar()	
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
		keyboard.down().onPressDo({personaje.abajoSiPuede()})
		keyboard.up().onPressDo({personaje.arribaSiPuede()})
		
		// Inventario:
		keyboard.space().onPressDo({personaje.objetoEnMano().usar()})
		keyboard.q().onPressDo({personaje.equiparObjeto(0)})
		keyboard.w().onPressDo({personaje.equiparObjeto(1)})
		keyboard.e().onPressDo({personaje.equiparObjeto(2)})
		keyboard.r().onPressDo({personaje.equiparObjeto(3)})
		keyboard.t().onPressDo({personaje.equiparObjeto(4)})
		
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

	method agregarObjetos(){}
	method agregarEnemigos(){}
	method interacciones(){}

	method iniciar(){
		self.agregarObstaculos()
		self.agregarObjetos()
		self.agregarEnemigos()
	}
	
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
}


object nivel0 inherits Nivel {
	
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
		game.addVisual(banderaRoja)
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

	override method agregarObstaculos(){
		game.width().times{col=> 
			if (col != 23)
				self.nuevoBloque(game.at(col-1,2),"piedra.jpg")}
		
		game.width().times{col=> 
			self.nuevoBloque(game.at(col-1,0),"tierra.png")}
		
		self.nuevoFuego(game.at(8,3))
		game.schedule(350,{self.nuevoFuego(game.at(12,3))})
		
	}
			
	override method agregarEnemigos(){
		game.addVisual(caballero)
	}
}