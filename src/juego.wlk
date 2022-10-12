import wollok.game.*
import personaje.*
import obstaculos.*
import interactuables.*

object juego{
	method iniciar(){
		self.configurarJuego()
		self.agregarObstaculos()
		self.agregarObjetos()
		self.configurarTeclas()
		self.interacciones()
		game.start()
	}
	
	method configurarJuego(){
		game.title("Las aventuras de Jerry")
		game.addVisual(personaje)
		game.width(25)
		game.height(15)
		game.boardGround("fondo.jpg")	
	}
	
	method configurarTeclas() {
		keyboard.left().onPressDo({personaje.izquierda()})
		keyboard.right().onPressDo({personaje.derecha()})
	}
	
	method agregarObstaculos(){
		game.width().times{col=> 
			if (col != 5)
				self.nuevoObstaculo(game.at(col-1,2),"piedra.jpg")}
		game.width().times{col=> 
			self.nuevoObstaculo(game.at(col-1,0),"tierra.png")}
		self.nuevoFuego(game.at(8,1))
	}
	
	method agregarObjetos(){
		self.nuevoObstaculo(game.at(4,2),"escaleraDoble.png")
		game.addVisual(bandera)
		game.addVisual(caja)
		game.addVisual(boton)
	}
	method nuevoObstaculo(posicion,imagen){
		const obstaculo = new Objeto(position = posicion,image = imagen)
		game.addVisual(obstaculo)
	}
	method nuevoFuego(posicion){
		const fuego = new Fuego(position = posicion,image = "fuego.png")
		fuego.fuegoIntermitente()
	}
	
	method interacciones(){
		game.onCollideDo(caja, {chocado => chocado.interactuarConCaja()})
		game.onCollideDo(boton,{_ => caja.tocarBoton()})
		game.onCollideDo(bandera,{chocado => bandera.ganaste()})
	}
}