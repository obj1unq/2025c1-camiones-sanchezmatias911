object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }

	//metodos polimorficos para agregar
	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso // RENOMBRAR FUNCION

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()

	method pesoEntre(min,max){self.peso().between(min, max)}

	method bulto() = 1

	method realizaCambios(){}
	// metodos polimorficos para agregar
}

object bumblebee {

	var property equipado = auto

	method peso() { return 800 }

	method nivelPeligrosidad() = 
		equipado.nivelPeligrosidad()

	
	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso // RENOMBRAR FUNCION

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()

	method pesoEntre(min,max){self.peso().between(min, max)}

	method bulto() = 2

	method realizaCambios(){self.equipado(robot)}

}
object auto{
	method nivelPeligrosidad() = 15
	}
object robot{

	method nivelPeligrosidad() = 30
}



// LADRILLO
object paqueteDeLadrillos{

	const  ladrilloEmpaquetado = ladrillo

	method peso() = ladrilloEmpaquetado.pesoLadrillo() * ladrilloEmpaquetado.cantidad()

	method prepararPaquete(cantidad){
		ladrillo.cantidad(cantidad)
	}
	
	


	method nivelPeligrosidad() = 2

	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso 

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()

	method pesoEntre(min,max){self.peso().between(min, max)}

	method bulto() {return self.tipoDeBultoEnPaquete(ladrilloEmpaquetado.cantidad())}

	
	method tipoDeBultoEnPaquete(cantidad){
		if       (cantidad.between(1, 100))     {return 1}
		else  if (cantidad.between(101, 300))   {return 2}
		else                                    {return 3}
	}

	method realizaCambios(){
		const nuevoValor = ladrilloEmpaquetado.cantidad() + 12
		ladrilloEmpaquetado.cantidad(nuevoValor)
	}
	
}



object ladrillo {
	/*
		El ladrillo sabe decir su peso y la cantidad en el paquete 

	*/

	var cantidad = 1

	method pesoLadrillo() = 2

	method cantidad() = cantidad 

	method cantidad(_cantidad) {
		self.validarCantidad(_cantidad)
		cantidad = _cantidad
	}

	method validarCantidad(cant){
		if(cant < 0){self.error("Debes cargar al menos 1 ladrillo")}
	}

	
	
}
	// ################################################################################################	
	

	

object arenaAGranel{

	var  property peso = 10


	method nivelPeligrosidad() = 1

	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(pesoDado) = self.peso() == pesoDado // RENOMBRAR FUNCION

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()

	method pesoEntre(min,max){self.peso().between(min, max)}

	method bulto() = 1

	method realizaCambios(){
		const nuevoValor = self.peso() + 20
		self.peso(nuevoValor)
	}
}


object bateriaAntiaerea{
	
	/*
		*Equipar o desequipar los misiles es responsabilidad de la bateria. 
		*Verificar que esta equipado en la bateria es responsabilidad del misil
	*/
	
	const misil = misiles

	method peso() = self.pesoBateria() + misil.pesoMisil()

	method nivelPeligrosidad() = self.estadoBateria()


	method estadoBateria() = if (misil.estoyEquipado()) 100 else 0

	//method estoyEquipado() = misil.equipado()

	//method estadoPeligrosidad() = if(misil.equipado()) 100 else 0
	

	method pesoBateria() = 200

	

	method equiparMisiles(){misiles.equipar()}

	method desequiparMisiles(){misiles.desequipar()}



	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso 

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = (self.nivelPeligrosidad()>cosa.nivelPeligrosidad())

	method pesoEntre(min,max){self.peso().between(min, max)}

	method bulto() = if (misil.estoyEquipado()) 2 else 1 

	method realizaCambios(){
		self.equiparMisiles()
	}

}

object misiles{
	var equipado  = false 

	method equipar() { equipado = true}

	method desequipar() { equipado = false}

	method pesoMisil() = if (equipado) 100 else 0

	method estoyEquipado() = equipado
}

object contenedorPortuario{

	const  cargaContenedor = []

	method cargaContenedor() = cargaContenedor
	// ################ PESO #############################

	method peso() = self.pesoContenedor() + self.pesoCarga()

	method pesoContenedor()= 100

	method pesoCarga() = cargaContenedor.sum({cosa => cosa.peso()}) // me da 0 si no hay carga

	// ################ NIVEL PELIGROSIDAD ##############
	
	// CASO 1: uso de maxIfEmpty con valor con defecto
	

	method nivelPeligrosidad() = self.nivelMasPeligroso()

	method nivelMasPeligroso() = self.misNiveles().maxIfEmpty({0}) // si no tengo carga retorna 0 

	method misNiveles() = cargaContenedor.map({carga => carga.nivelPeligrosidad()}).asSet()
	
	
    // CASO 2: sin maxIfEmpty
	/*

	method nivelPeligrosidad() = self.nivelMasPeligroso()

	method nivelMasPeligroso() = if (self.tengoCarga()) {self.misNiveles().max()} else {0}

	method misNiveles() = cargaContenedor.map({carga => carga.nivelPeligrosidad()}).asSet() // si esta vacio retorna #{}

	method tengoCarga() = not cargaContenedor.isEmpty()
	*/



	//######### settearCarga ######
	method cargarContenedor(cosa){cargaContenedor.add(cosa)}

	method descargarContenedor(cosa){cargaContenedor.remove(cosa)}

	
	//######### carga #########
	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso 

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()

	method pesoEntre(min,max){self.peso().between(min, max)}

	method bulto () = self.bultoContenedor() + self.bultoCarga()

	method bultoContenedor() = 1 

	method bultoCarga() = cargaContenedor.sum({carga => carga.bulto()}) 

	method realizaCambios(){
		cargaContenedor.forEach({cosa => cosa.realizaCambios()})
	}

}

object residuos{
	var property peso = 10

	method nivelPeligrosidad()= 200

	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(pesoDado) = self.peso() == pesoDado // RENOMBRAR FUNCION

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()

	method pesoEntre(min,max){self.peso().between(min, max)}

	method bulto() = 1

	method realizaCambios(){
		const nuevoPeso = self.peso() + 15
		self.peso(nuevoPeso)

	}

}

object embalajeDeSeguridad{

	const cosaEmbalada = bumblebee

	method peso() = cosaEmbalada.peso()

	method nivelPeligrosidad()= cosaEmbalada.nivelPeligrosidad() / 2

	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso 

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()

	method pesoEntre(min,max){self.peso().between(min, max)}

	method bulto() = 2

	method realizaCambios(){}

}






