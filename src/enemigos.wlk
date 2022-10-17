import wollok.game.*
import personaje.*
import interactuables.*

object caballero{
	var property position = game.at(22,3)
	var property image = "caballeroIzq.png"
	
	method interactuar(){
		if (personaje.objetoEnMano() == espada){
			game.removeVisual(self)
			espada.tirarObjeto()
		}
		else
			personaje.muere()
	}
}
