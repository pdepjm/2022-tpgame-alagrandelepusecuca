import wollok.game.*
import personaje.*
import obstaculos.*
import interactuables.*

object juego{
	method iniciar(){
		self.configurarJuego()
		self.agregarObstaculos()
		self.configurarTeclas()
		self.interacciones()
		game.start()
	}
	
	method configurarJuego(){
		game.title("GG")
		game.addVisual(personaje)
		game.width(25)
		game.height(15)
		
	}
	
	method configurarTeclas() {
		keyboard.left().onPressDo({personaje.izquierda()})
		keyboard.right().onPressDo({personaje.derecha()})
	}
	
	method agregarObstaculos(){
		game.width().times{col=>
			self.nuevoObstaculo(game.at(col-1,2),"piedra.jpg")}
		game.addVisual(caja)
		game.addVisual(escaleraArriba)
		game.addVisual(escaleraMedio)
		game.addVisual(boton)
		game.width().times{col=>
			self.nuevoObstaculo(game.at(col-1,0),"tierra.png")}
		
		game.addVisual(fuego)
	}
	method nuevoObstaculo(posicion,imagen){
		const obstaculo = new Obstaculo(position = posicion,image = imagen)
		game.addVisual(obstaculo)
	}
	
	method interacciones(){
		game.onCollideDo(caja,{chocado => caja.moverADerecha()})
		game.onCollideDo(boton,{chocado => caja.tocarBoton()})
		//game.onCollideDo(escaleraAbajo,{chocado => chocado.subirEscalera()})
		game.onTick(5000,"chau",{game.removeVisual(fuego)})
		game.onTick(10000,"hola",{game.addVisual(fuego)})
		game.onCollideDo(fuego,{chocado => chocado.muere()})
	}
}