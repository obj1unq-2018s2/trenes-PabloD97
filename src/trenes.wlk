class Locomotora{
	var property peso
	var property arrastreMaximo = 0
	var property velocidadMax = 0

	method arrastreUtil()= arrastreMaximo - peso

}

class VagonDePasajeros{
	
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
}

class VagonDeCarga{
	var property cargaMax
	
	method cargaMax(){
		return cargaMax + 160
	}
	
	method pasajerosQuePuedeTransportar()= 0
}


class Formaciones{
	var property locomotoras
	var property vagones
	

	method agregarLocomotora(locomotora){
		locomotoras.add(locomotora)
	}
	
	method agregarVagon(vagon){
		vagones.add(vagon) 
	}
	
	method pasajeros(){
		vagones.map({ vagon=>vagon.pasajerosQuePuedeTransportar()}).sum()
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
}


class Deposito{
	var property formaciones
	var property locomotorasSueltas
	
	method agregarLocomotoraSuelta(formacion){
		formacion.locomotoras.add(locomotorasSueltas.anyOne())
	}
	
	method vagonesPesados(){
		return	formaciones.map(
			{ formacion=>formacion.vagonMasPesado() }).asSet()
	}
}





