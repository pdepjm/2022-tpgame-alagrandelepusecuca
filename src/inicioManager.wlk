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
			juego.iniciar()
		}
		keyboard.c().onPressDo({game.addVisual(controles)})
	}
}

object pantallaInicio {
	const property image = "pantallaInicio2.png"
	const property position = game.origin()
}	
object controles {
	const property controles = "controles.png"
	const property position = game.at(19,10)
}
