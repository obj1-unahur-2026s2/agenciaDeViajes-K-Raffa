class Packs{
    var duracionEnDias
    var precioBase 
    var beneficiosEspeciales = []
    var coordinadorACargo 
    
    // BENEFICIOS
    method agregarBeneficio(beneficio){
        beneficiosEspeciales.add(beneficio)
    }

    method costoBeneficiosVigentes(){
       return  beneficiosEspeciales.filter({b=> b.estaVigente()}.sum({b=>b.costo()}))
    }

    // PRECIO FINAL
    method recargo() 

    method precioFinal() = (precioBase + self.costoBeneficiosVigentes()) * self.recargo() 
    
    // PACKS PREMIUMS

    method premium()

    method duracionEnDias(){
        return duracionEnDias
    }

    method precioBase(){
        return precioBase
    }

    method beneficiosEspeciales(){
        return beneficiosEspeciales
    }
    
    method coordinadorACargo(){
        return coordinadorACargo
    }
}

class Nacionales inherits Packs{
    const provinciaDestino 
    const actividadesIncluidas = []
    var ciudadesAVisitar

    method provinciaDestino(){
        return provinciaDestino
    }

    method actividadesIncluidas(nombreAct){
       return actividadesIncluidas.add(nombreAct)
    }
    
    override method recargo() = 1

    override method premium(){
        return self.duracionEnDias() >10 &&  self.coordinadorACargo().estaAltamenteCalificado()
    }

    method ciudadesAVisitar(){
        return ciudadesAVisitar 
    }

}

class Provinciales inherits Nacionales{
    override method premium(){
        return self.actividadesIncluidas(nombreAct).size() > 4 && self.beneficiosEspeciales().size() >= 3 && self.ciudadesAVisitar() > 5 
    }

    override method recargo() = 1.05
}
class Internacionales inherits Packs{
    const paisDestino 
    const cantDeEscalas 
    const esLugarDeInteres

    override method recargo() = 1.2

    override method premium() = self.esLugarDeInteres() && self.duracionEnDias() && cantDeEscalas == 0
    
    method paisDestino(){
        return paisDestino
    }
    
    method cantDeEscalas(){
        return cantDeEscalas
    }

    method esLugarDeInteres(){
        return esLugarDeInteres
    }
}

class BeneficiosOpcionales{
    const tipo
    const costo 
    const estaVigente

    method tipo(){
        return tipo
    } 

    method costo(){
        return costo
    }

    method estaVigente(){
        return estaVigente
    }
}

class Coordinador{
    const viajesRealizados
    const estaMotivado
    const añosExperiencia
    var rol 

    method viajesRealizados(){
        return viajesRealizados
    }

    method estaMotivado(){
        return estaMotivado
    }

    method añosExperiencia(){
        return añosExperiencia
    }

    method estaAltamenteCalificado(){
        return viajesRealizados > 20 && rol.cumpleCondicion(self)
    }
}

object guia{

    method cumpleCondicion(coordinador){
        return coordinador.estaMotivado()
    }  
}

object asistenteLogistico{
    
     method cumpleCondicion(coordinador){
        return coordinador.añosExperiencia() >= 3
    }

}

object acompañante{
    
    method cumpleCondicion(coordinador){
        return true
    }
}