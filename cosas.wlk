object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }

	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso // RENOMBRAR FUNCION

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()
}

object bumblebee {
	method peso() { return 800  }

	method nivelPeligrosidad() = 
		estado.nivelPeligrosidad()

	
	 var property estado = auto
}
object auto{
	method nivelPeligrosidad() = 15
	}
object robot{

	method nivelPeligrosidad() = 30
}

object paqueteDeLadrillos{

	var property ladrillos = 1
	method peso() = 2 * ladrillos
	method nivelPeligrosidad() = 

	
}





