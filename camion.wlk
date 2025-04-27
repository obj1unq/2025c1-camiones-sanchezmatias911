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
			*no hay cosas repetidas en el camion
	*/
	const property cosas = #{}

	
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
		unaCosa.realizaCambios()
	}

	method descargar(unaCosa){
		cosas.remove(unaCosa)
	}
	// para remover todo
	method entregaConfirmada(){cosas.clear()}

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



//###################################
// IMPLEMENTAR TRANSPORTE
//##############################

/*
requerimientos: 
	*al llegar al almacen pasar los objetos de 
	camion al almacen y borrar los propios del camion
	*
*/
method transportar(destino,camino){
	//self.validarPesoCamion()
	self.validarDestino(destino)
	self.validarCamino(camino)
	
	self.entregar(destino)
	 //borra elementos de la coleccion de camion
}

method entregar(destino){
	const entregas = cosas.copy()
	destino.depositar(entregas)
	self.entregaConfirmada() 
}
/*
method validarPesoCamion(){
	if ( self.excedidoDePeso()) {
		self.error("El camion se encuentra escedido de peso")
	}
}*/

method validarDestino(destino){
	if( not  destino.puedeAlmacenar(self)) { 
		self.error("No puedo almacenar la carga en el destino")
	}
}

method validarCamino(camino){
	if (not  camino.puedeCircular(self)) {
		self. error("No puedo transitar el camino.Nivel de peligrosidad mayor o excedido de peso")
		}  
}


method entregaProgramada(bloque){
	bloque.apply()
}
}
object almacen{

    const deposito = []

	method deposito() = deposito // PARA TESTEAR

	var property bultoMaximo = 10

	method depositar(cargaCamion){
		deposito.addAll(cargaCamion)
	}

	method puedeAlmacenar(camion){
		return camion.totalBultos() <= self.bultoMaximo()
	}
}
//OTRO ALMACEN PARA TESTEAR
object almacenDos{

    const deposito = []

	method deposito() = deposito // PARA TESTEAR

	var property bultoMaximo = 3

	method depositar(cargaCamion){
		deposito.addAll(cargaCamion)
	}

	method puedeAlmacenar(camion){
		return camion.totalBultos() <= self.bultoMaximo()
	}
}
// ##############################

object ruta9{
	var property peligrosidad =  11

	method puedeCircular(camion){
		return camion.puedeCircularEnRuta(self.peligrosidad())
	}
	
		
	}


object caminosVecinales {

	var property pesoMaximo = 4000

	method puedeCircular(camion){
		return camion.pesoTotal() <=  self.pesoMaximo()
	}
	

}

