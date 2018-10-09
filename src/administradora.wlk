import trenes.*

class Administradora {
	
	method cantVagonesLivianos(formacion){
		formacion.count({vagon=> vagon.vagones().cargaMax() < 2500 }) 
	}
	
	
	method velocidadMaxDeFormaciones(formacion){
		fomarciones
	}
}
