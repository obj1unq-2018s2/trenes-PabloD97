import trenes.*

object administradora {
	
	method cantVagonesLivianos(formacion){
		formacion.count({vagon=> vagon.vagones().cargaMax() < 2500 }) 
	}
	
}
