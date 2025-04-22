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

	method pesoTotal() = self.miPeso() + self.pesoTotalCarga()

	method miPeso(){
		return 1000
	}

	method pesoTotalCarga() = cosas.sum({cosa => cosa.peso()})
		

	method excedidoDePeso() = self.pesoTotal() > 2500

	method objetosQueSuperanPeligrosidad(nivel){
		return cosas.filter({cosa => cosa.superoNivel()})
	}
	method objectosMasPeligrososQue(cosa) = 
		cosas.filter({miCosa => miCosa.soyMasFuerteQue(cosa)})

	method puedeCircularEnRuta(nivelMaximoPeligrosidad) = 
		not self.estoyExcedido() AND self.funcion() // RENOMBRAR

method estoyExcedido() = true

method funcion() = true



	

	
}



