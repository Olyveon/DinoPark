extends Node

enum Etapa {
	BEBE,
	ADULTO
}

class Dinosaurio:
	var id: int
	var nombre: String
	var etapa: Etapa
	var evolucion_siguiente: Etapa  # Agregamos el atributo 'evolucion_siguiente'

	func _init(id: int, nombre: String, etapa: Etapa, evolucion_siguiente: Etapa):
		self.id = id
		self.nombre = nombre
		self.etapa = etapa
		self.evolucion_siguiente = evolucion_siguiente  # Inicializamos 'evolucion_siguiente'

# Diccionario con los dinosaurios
var dinosaurios = {
	1: Dinosaurio.new(1, "Tiranosaurio", Etapa.BEBE, Etapa.ADULTO),
	2: Dinosaurio.new(2, "Alosaurio", Etapa.BEBE, Etapa.ADULTO),
	3: Dinosaurio.new(3, "Espinosaurio", Etapa.BEBE, Etapa.ADULTO),
	4: Dinosaurio.new(4, "Estegosaurio", Etapa.BEBE, Etapa.ADULTO),
	5: Dinosaurio.new(5, "Parasaurio", Etapa.BEBE, Etapa.ADULTO),
	6: Dinosaurio.new(6, "Gigantosaurio", Etapa.BEBE, Etapa.ADULTO),
	7: Dinosaurio.new(7, "Velocirraptor", Etapa.BEBE, Etapa.ADULTO),
	8: Dinosaurio.new(8, "Triceratops", Etapa.BEBE, Etapa.ADULTO),
}

# Función para evolucionar un dinosaurio
func evolucionar_dinosaurio(id_dinosaurio: int):
	if dinosaurios.has(id_dinosaurio):
		var dinosaurio = dinosaurios[id_dinosaurio]
		dinosaurio.etapa = dinosaurio.evolucion_siguiente 
		print(str(dinosaurio.nombre)) # Se accede correctamente a 'evolucion_siguiente'
		print("El dinosaurio ha evolucionado a adulto")
	else:
		print("Dinosaurio no encontrado.")
