import wollok.game.*
import personaje.*
import interactuables.*

object caballero{
	var property position = game.at(12,7)
	var property image = "caballeroDer.png"
	
	method interactuar(){
		if (personaje.objetoEnMano() == espada){
			game.removeVisual(self)
			espada.tirarObjeto()
		}
		else
			personaje.muere()
	}
}
