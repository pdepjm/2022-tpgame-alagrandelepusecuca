import wollok.game.*
import juego.*

object inicioManager {
	
	method inicializar() {
		game.width(25)
		game.height(15)
		game.boardGround("fondo.jpg")
		game.addVisual(pantallaInicio)
		keyboard.enter().onPressDo {
			game.removeVisual(pantallaInicio)
			if(game.hasVisual(controles)){game.removeVisual(controles)}
			juego.iniciar()
		}
		keyboard.c().onPressDo({controles.titila()})
		
	}
}

object pantallaInicio {
	const property image = "pantallaInicio2.png"
	const property position = game.origin()
}	
object controles {
	const property image = "controles2.png"
	const property position = game.at(17,2)
	
	method titila(){
		if(game.hasVisual(self))
			game.removeVisual(self)
		else{
			game.addVisual(self)
		}
	}
}
