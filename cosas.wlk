object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }

	//metodos polimorficos para agregar
	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso // RENOMBRAR FUNCION

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()
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
}
object auto{
	method nivelPeligrosidad() = 15
	}
object robot{

	method nivelPeligrosidad() = 30
}

object paqueteDeLadrillos{

	var  property cantidadLadrillos = 1

	method peso() = self.pesoLadrillo() * cantidadLadrillos

	method pesoLadrillo() = 2

	method nivelPeligrosidad() = 2

	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso 

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()

	
}
object arenaAGranel{

	var  property peso = 10


	method nivelPeligrosidad() = 1

	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(pesoDado) = self.peso() == pesoDado // RENOMBRAR FUNCION

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()
	
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
}

object misiles{
	var equipado  = true 

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

	method misNiveles() = cargaContenedor.map({carga => carga.nivelPeligrosidad()}).asSet() // si esta vacio retorna []

	method tengoCarga() = not cargaContenedor.isEmpty()
	*/



	//######### settearCarga ######
	method cargarContenedor(cosa){cargaContenedor.add(cosa)}

	method descargarContenedor(cosa){cargaContenedor.remove(cosa)}

	
	//######### carga #########
	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso // RENOMBRAR FUNCION

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()
}

object residuos{}

object embalajeDeSeguridad{}



/* AGREGAR A TODOS

	method peso() =

	method nivelPeligrosidad()=

	method miPesoEsPar() = self.peso().even()
	
	method tienePeso(peso) = self.peso() == peso // RENOMBRAR FUNCION

	method sosDeNivel(nivel) = self.nivelPeligrosidad() == nivel

	method superoNivel(nivel) = self.nivelPeligrosidad() > nivel

	method soyMasFuerteQue(cosa) = self.nivelPeligrosidad()>cosa.nivelPeligrosidad()
	
	*/


