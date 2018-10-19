class Locomotora{
	var property peso
	var property arrastreMaximo = 0
	var property velocidadMax = 0

	method arrastreUtil()= arrastreMaximo - peso

}




//			VAGONES

class Vagon{
	method banios()= 0
}

class VagonDePasajeros inherits Vagon   {
	
	var largo
	var ancho
	
	method pasajerosQuePuedeTransportar(){
		if(ancho <= 2.5 ){
			return largo * 8
		}
		else{ return largo * 10 }
	}
	
	method cargaMax(){
		return self.pasajerosQuePuedeTransportar() * 80
	}
	
	override method banios(){
		return self.pasajerosQuePuedeTransportar() / 50
	} 

}

class VagonDeCarga  inherits Vagon {
	var property cargaMax
	
	method cargaMax(){
		return cargaMax + 160
	}
	
	method pasajerosQuePuedeTransportar()= 0
	
	override method banios()= 0 
}






//					Formaciones

class Formaciones {
	var property locomotoras
	var property vagones
	

	method agregarLocomotora(locomotora){
		locomotoras.add(locomotora)
	}
	
	method agregarVagon(vagon){
		vagones.add(vagon) 
	}
	
	method pasajeros(){
		return vagones.map({ vagon=>vagon.pasajerosQuePuedeTransportar()}).sum()
	}
	
	method cantVagonesLivianos(){
		return	vagones.count({vagon=> vagon.cargaMax() < 2500 }) 
	}
	
	method velocidadMaxDeFormaciones(){
		return locomotoras.min({ locomotora=> 
								 locomotora.velocidadMax()}).velocidadMax()
	}
	
	method formacionEficiente(){
		return locomotoras.all({
			locomotora=> locomotora.arrastreUtil() > 5*locomotora.peso()
		})
	} 
	
	method arrastreUtilTotal(){
		return locomotoras.map({locomotora=>locomotora.arrastreUtil()}).sum()
	}
	
	method pesoMaxTotal(){
		return vagones.map({vagon=>vagon.cargaMax()}).sum()
	}
	
	method formacionPuedeMoverse(){
		return self.arrastreUtilTotal() >= self.pesoMaxTotal()	
	
	}
	
	method kilosFaltantes(){
		if( self.formacionPuedeMoverse() ){
			return 0
		}
		else{
			return self.pesoMaxTotal() - return self.arrastreUtilTotal()
		}
	}
	
	method vagonMasPesado(){
		return	vagones.max({ vagon=> vagon.cargaMax()})	
	}
	
	method cantidadDeUnidades(){
		return locomotoras.size() + vagones.size()
	}
	method pesoTotalDeLocomotoras(){
		return locomotoras.map({locomotora=>locomotora.peso()}).sum()
	}
	method pesoTotal(){
		return self.pesoMaxTotal() + self.pesoTotalDeLocomotoras()
	}
	
	method esCompleja(){
		return self.cantidadDeUnidades() > 20 or self.pesoTotal() > 10000
	}
	
	method bienArmada(){
		return self.formacionPuedeMoverse() 
	}
}


//    		FORMACION DE CORTA DISTANCIA
class FormacionCortaDistancia inherits Formaciones {
	
	
	override method bienArmada(){
		return super() and not(self.esCompleja()) 
	}
	
	override method velocidadMaxDeFormaciones(){
		return super().min(60)
	}
}


// 				FORMACION DE LARGA DISTANCIA
class FormacionLargaDistancia inherits Formaciones {
	
	var property uneDosCiudadesGrandes
	 
	
	method baniosTotales(){
		return	vagones.map({
					vagon => vagon.banios()
				}).sum()
	}
	
 	method baniosSufiecientes(){
 		return self.baniosTotales() == self.pasajeros() / 50
	}
	
	override method bienArmada(){
		return super() && self.baniosSufiecientes()
	}

	override method velocidadMaxDeFormaciones(){
		return if(uneDosCiudadesGrandes){ 200 }
			else{ 150 }
	}
}

//				 FORMACION DE ALTA VELOCIDAD
class TrenDeAltaVelocidad inherits FormacionLargaDistancia {
	
	
	const velocidadMinima=250 
	
	method sonTodosLosVagonesLivianos(){
		return self.cantVagonesLivianos() == vagones.size()
	}
	
	override method velocidadMaxDeFormaciones(){
		return locomotoras.min({ locomotora=> 
								 locomotora.velocidadMax()}).velocidadMax()
	}
	
	override method bienArmada(){
		return 
			self.sonTodosLosVagonesLivianos() 
			and 
			self.velocidadMaxDeFormaciones() > velocidadMinima
	}
	
}

// 				DEPOSITO
class Deposito{
	var property formaciones
	var property locomotorasSueltas
	

	method vagonesPesados(){
		return	formaciones.map(
			{ formacion=>formacion.vagonMasPesado() }).asSet()
	}
	
	method necesitaConductorExperimentado(){
		return formaciones.any({formacion => formacion.esCompleja()})
	}
	
	method agregarLocomotora(formacion){
		var locomotoraUtil = locomotorasSueltas.find({
				locomotora=> 
					locomotora.arrastreUtil() >= formacion.kilosFaltantes()
		})
		
		if(not formacion.formacionPuedeMoverse()){
			formacion.agregarLocomotora(locomotoraUtil)
			locomotorasSueltas.remove(locomotoraUtil)
		}
	}
	
}






