import wollok.game.*
import personaje.*
import interactuables.*

object caballero{
	var property position = game.at(12,7)
	var property image = "enemigos/caballeroIzq.png"
	
	method interactuar(){
		if (personaje.objetoEnMano() == espada){
			image = "enemigos/caballeroIzqMuerto.png"
			espada.tirarObjeto()
			position = position.left(1)
			game.schedule(500,{game.removeVisual(self)})
			game.schedule(500,{game.addVisual(escudo)})
		}
		else
			personaje.muere()
	}
}

class Flecha{
	var property position = game.at(24,4)
	var property image = "flecha1.png"

	method flechaIntermitente(){
		game.onTick(1000,"Cambiar imagen",{self.cambiarImagen()})
		
	}
	method cambiarImagen(){
		game.schedule(250,{image ="flecha1.png"})
		game.schedule(500,{image ="flecha2.png"})
		game.schedule(750,{image ="flecha3.png"})
		game.schedule(1000,{self.moverBox()})
	}
	
	method moverBox(){
		position = position.left(1)
		image = "flecha1.png"
	}

	method interactuar(){
		if(personaje.objetoEnMano() != agachado){
			personaje.muere()
		}
	} 
	
}

object mago{
	var property position = game.at(15,10)
	var property image = "enemigos/mago.png"
	method disparar(){
		self.crearFuego()
		game.onTick(1200,"DisparoFuego",{self.crearFuego()})
	}
	method crearFuego(){
		if (game.hasVisual(self)){
			const fueguito = new FuegoMago()
			game.addVisual(fueguito)
			game.onTick(600,"DisparoFuego",{fueguito.moverse()})
		}
	}
	method interactuar(){
		personaje.muere()
	}

	method quemarse(objeto){
		game.removeVisual(objeto)
		image = "enemigos/magoQuemandose.png"
		game.schedule(200,{game.removeVisual(self)})
	}
}


class FuegoMago{
	var property image = "enemigos/fuegoMago.png"
	var property position = mago.position().left(1)
	method moverse(){
		position = position.left(1)
	}
	method interactuar(){
		if (personaje.objetoEnMano() == escudo and personaje.direccion() == derecha)
			game.removeVisual(self)
		else
			personaje.muere()
	}
}