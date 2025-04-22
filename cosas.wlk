object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }

	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso // RENOMBRAR FUNCION

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()
}




