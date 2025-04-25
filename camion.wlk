import cosas.*


/*
	las cosas entienden nivelDePeligrosidad
	y peso
*/
object camion {

	/*
		REQUERIMIENTOS:
			*No sobrepasar capacidad
			*depende la peligrosidad puede llegar o no a un destino
	*/
	const property cosas = #{}
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
	}

	method descargar(unaCosa){
		cosas.remove(unaCosa)
	}

	method todoPesoPar(peso) =  cosas.all({cosa => cosa.miPesoEsPar()} )
		
	method hayAlgunoQuePesa(peso) =  cosas.any({cosa => cosa.tienePeso(peso)} ) // RENOMBRAR FUNCION
	

	method elDeNivel(nivel) = cosas.find({cosa => cosa.sosDeNivel(nivel)})

	method pesoTotal() = self.pesoCamion() + self.pesoTotalCarga()

	method pesoCamion(){
		return 1000
	}

	method pesoTotalCarga() = cosas.sum({cosa => cosa.peso()})
		

	method excedidoDePeso() = self.pesoTotal() > self.pesoLimite()

	method pesoLimite() = 2500

	method objetosQueSuperanPeligrosidad(nivel){
		return cosas.filter({cosa => cosa.superoNivel(nivel)})
	}

	method objectosMasPeligrososQue(cosa) = 
		cosas.filter({miCosa => miCosa.soyMasFuerteQue(cosa)})

	method puedeCircularEnRuta(nivelMaximoPeligrosidad) = 
		(not self.excedidoDePeso()) and 
	not (self.noLLevoPeligrososDeNivel(nivelMaximoPeligrosidad)) // RENOMBRAR


method noLLevoPeligrososDeNivel(nivelMaximoPeligrosidad){
//busco no tener cosas que superen el nivel maximo de peligrosidad indicado

	return self.objetosQueSuperanPeligrosidad(nivelMaximoPeligrosidad).isEmpty()
}

// ############## agregados a camion ########

method tieneAlgoQuePesaEntre(min,max){
	return cosas.any({cosa => cosa.pesoEntre(min,max)}) // implementar pesoEntre en todos los demas objetos
}

//###########################################
// preguntar si debo validar si tengo carga o usar maxIfEmpty
method cosaMasPesada(){
	self.validarSiHayCarga()
	return cosas.max({cosa => cosa.peso()})
}

method validarSiHayCarga(){
	if (not self.tengoCarga()){
		self.error("No tengo carga para darte cosa mas pesada")
	}
}

method tengoCarga() = not (cosas.isEmpty())

// ###########################################

method pesos() = cosas.map({cosa => cosa.peso()})

method pesosSet() = self.pesos().asSet()



method totalBultos(){
	return cosas.sum({cosa => cosa.bulto()})
}



	

	
}



