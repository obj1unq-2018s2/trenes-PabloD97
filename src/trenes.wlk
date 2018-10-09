class Locomotora{
	var property peso
	var arrastreUtil
	var property velocidadMax
	
	method arrastreUtil(){
		return	arrastreUtil -= arrastreUtil - peso
	}
}

class VagonDePasajeros{
	
	const largo
	const anchoUtil
	var property totalDePasajeros
	
	method pasajerosQuePuedeTransportar(){
		if(anchoUtil <= 2.5 ){
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
	
	method totalDePasajeros()= 0
}


class Formaciones{
	var property locomotoras
	var property vagones
	var pasajerosTotales= self.pasajeros()

	method agregarLocomotora(locomotora){
		locomotoras.add(locomotora)
	}
	
	method agregarVagon(vagon){
		vagones.add(vagon) 
	}
	
	method pasajeros(){
		vagones.map({ vagon=>vagon.totalDePasajeros()}).sume()
	}
}









