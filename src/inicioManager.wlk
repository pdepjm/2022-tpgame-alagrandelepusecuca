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
	}
}

object pantallaInicio {
	const property image = "pantallaInicio.png"
	const property position = game.origin()
}	

