import wollok.game.*
import personaje.*
import obstaculos.*
import interactuables.*
import extras.*

object juego{
	method iniciar(){
		self.configurarJuego()
		self.agregarObstaculos()
		self.agregarObjetos()
		self.interacciones()
		self.configurarPersonaje()
		game.start()
	}
	
	method configurarJuego(){
		game.title("Las aventuras de Jerry")
		game.addVisual(personaje)
		game.width(25)
		game.height(15)
		game.boardGround("fondo.jpg")	
	}
	
	method configurarPersonaje(){
		keyboard.left().onPressDo({personaje.izquierda()})
		keyboard.right().onPressDo({personaje.derecha()})
		game.addVisual(corazon1)
		game.addVisual(corazon2)
		game.addVisual(corazon3)
	}
	
	method agregarObstaculos(){
		game.width().times{col=> 
			if (col != 5)
				self.nuevoObstaculo(game.at(col-1,2),"piedra.jpg")}
		
		game.width().times{col=> 
			self.nuevoObstaculo(game.at(col-1,0),"tierra.png")}
		self.nuevoFuego(game.at(8,3))
		game.schedule(350,{self.nuevoFuego(game.at(12,3))})
		
	}
	method nuevoObstaculo(posicion,imagen){
		const obstaculo = new Objeto(position = posicion,image = imagen)
		game.addVisual(obstaculo)
	}
	method nuevoFuego(posicion){
		const fuego = new Fuego(position = posicion,image = "fuego.png")
		fuego.fuegoIntermitente()
	}
	method agregarObjetos(){
		game.addVisual(caja)
		game.addVisual(boton)
		game.addVisual(bandera)
		game.addVisual(kit)
		self.nuevoObstaculo(game.at(4,2),"escaleraDoble.png")
		
	}
	method interacciones(){
		game.onCollideDo(caja, {chocado => chocado.interactuarConCaja()})
		game.onCollideDo(boton,{_ => caja.tocarBoton()})
		game.onCollideDo(bandera,{chocado => bandera.ganador()})
		game.onCollideDo(kit,{chocado => chocado.usarKit()})
	}
}