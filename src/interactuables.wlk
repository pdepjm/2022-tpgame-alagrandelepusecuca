import wollok.game.*
import personaje.*
import obstaculos.*
import extras.*


class Objeto{
	var property position
	var property image
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

const kit = new Objeto(position = game.at(18,3), image = "kit.png")

const escaleraAbajo = new Objeto(position = game.at(4,1),image = "escalera.png")

