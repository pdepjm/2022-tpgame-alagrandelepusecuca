import wollok.game.*
import personaje.*
import interactuables.*

object caballero{
	var property position = game.at(12,7)
	var property image = "enemigos/caballeroIzq.png"
	
	method interactuar(){
		if (personaje.objetoEnMano() == espada){
			game.removeVisual(self)
			espada.tirarObjeto()
			game.addVisual(escudo)
		}
		else
			personaje.muere()
	}
}

object flecha{
	var property position = game.at(24,4)
	var property image = "flecha1.png"
	var tiempo = 400

	method cambiarImagen(){
		/*
		game.onTick(tiempo * 3,"",{image ="flecha1.png"})
		game.schedule(tiempo,{game.onTick(tiempo * 3,"",{image ="flecha2.png"})})
		game.schedule(tiempo*2,{game.onTick(tiempo * 3,"",{image ="flecha3.png"})})
		*/
	}

	method moverse(){
		game.onTick(tiempo * 3,"Se mueve",{position = position.left(1)})
	}
	method interactuar(){
		if(personaje.objetoEnMano() != agachado){
			personaje.muere()
		}
	} 
}