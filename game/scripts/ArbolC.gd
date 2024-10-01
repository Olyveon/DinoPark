extends Node
var mision_labels = {}

# Referencia al contenedor donde mostrarás las misiones
@onready var mision_container = get_node("/root/Game/Interface/UI/Panel/Mision_container")
@onready var estructura = get_node("/root/Game/Utilities/Clist")
class MisionNode:
	var nombre: String
	var completada: bool = false
	var hijos: Array = []

	# Constructor para inicializar la misión y sus hijos
	func _init(nombre: String, hijos: Array = []):
		self.nombre = nombre
		self.hijos = hijos

	# Completar la misión y desbloquear las siguientes
	func completar_mision():
		completada = true
		print("Misión completada: " + nombre)

		# Desbloquear las misiones hijas
		for hijo in hijos:
			hijo.desbloquear_mision()

	# Desbloquear una misión (se puede mostrar visualmente)
	func desbloquear_mision():
		print("Misión desbloqueada: " + nombre)


# Crear el árbol de misiones
var cruce_mision = MisionNode.new("Cruza dos dinosaurios")
var evoluciona_mision = MisionNode.new("Evoluciona un dinosaurio", [cruce_mision])
var compra_dos_especies_mision = MisionNode.new("Compra dos especies", [evoluciona_mision])

var crea_edificio_especial_mision = MisionNode.new("Crea un edificio especial", [compra_dos_especies_mision])
var compra_dinosaurio_mision = MisionNode.new("Compra un dinosaurio", [compra_dos_especies_mision])
var crea_jaula_mision = MisionNode.new("Crea una jaula", [compra_dinosaurio_mision, crea_edificio_especial_mision])

var destruye_edificio_mision = MisionNode.new("Destruye un edificio")
var construye_edificio_mision = MisionNode.new("Construye un edificio", [destruye_edificio_mision, crea_jaula_mision])

# Nodo raíz, la primera misión
var raiz_mision = construye_edificio_mision


# Función que se ejecuta al inicio del juego o escena
func _ready():
	print("Juego iniciado")
	raiz_mision.desbloquear_mision()
	mostrar_misiones(raiz_mision)
	verificar_misiones(raiz_mision)


# Ejemplo de cómo se podría monitorizar el estado de las misiones
# Cada frame se comprueba si las condiciones de la misión se cumplen
#odrías tener una función que verifique si una misión debe completarse



# Función para mostrar las misiones en el panel
# Función para mostrar las misiones en el panel
func mostrar_misiones(mision: MisionNode):
	# Verificar si la misión ya ha sido mostrada
	if mision_labels.has(mision):
		return  # Salir si ya se mostró

	# Crear un HBoxContainer para la misión
	var hbox = HBoxContainer.new()

	# Crear un Label para la misión y agregarlo al HBoxContainer
	var label = Label.new()
	label.text = mision.nombre
	label.modulate = Color(1, 1, 1, 0.5)  # Texto gris para indicar que está bloqueada
	hbox.add_child(label)

	# Agregar el HBoxContainer al VBoxContainer creado en la interfaz
	mision_container.add_child(hbox)

	# Almacenar el label en un diccionario si necesitas acceder a él después
	mision_labels[mision] = label

	# Solo llamar a mostrar_misiones en hijos si la misión está desbloqueada
	if condicion_para_completar(mision):
		print("hola")
		for hijo in mision.hijos:
			mostrar_misiones(hijo)  # Llamada recursiva para los hijos


# Función para actualizar el estado visual de las misiones
func actualizar_mision_visual(mision: MisionNode):
	  # Verificar si la misión está en el diccionario
	if mision_labels.has(mision):
		var label = mision_labels[mision]
		
		if mision.completada:
			label.modulate = Color(0, 1, 0, 1)  # Texto verde si la misión está completada
		elif condicion_para_completar(mision):
			label.modulate = Color(1, 1, 1, 1)  # Texto blanco si está desbloqueada pero no completada
		else:
			label.modulate = Color(1, 1, 1, 0.5)  # Texto gris si está bloqueada
	else:
		print("Error: La misión no se encontró en mision_labels.")


# Verifica y actualiza todas las misiones en el árbol
func verificar_misiones(mision: MisionNode):
	print("Verificando misión:", mision.nombre)  # Mensaje de depuración

	# Verifica si la misión ya está completada
	if mision.completada:
		print("Misión ya completada:", mision.nombre)  # Mensaje de depuración
		 # Salir si ya está completada

	# Si no está completada y se puede completar, lo hacemos
	if condicion_para_completar(mision):
		confirmar_completado(mision)  # Completar la misión si se cumplen las condiciones

	# Revisa todas las misiones hijas
	for hijo in mision.hijos:
		verificar_misiones(hijo)  # Llamada recursiva para las misiones hijas


# Función que completa la misión si se cumplen las condiciones
func confirmar_completado(mision: MisionNode):
	if not mision.completada:  # Verifica si no ha sido completada antes
		mision.completar_mision()  # Completa la misión
		actualizar_mision_visual(mision)  # Actualiza su visualización


# Función que verifica la condición de completar cada misión
func condicion_para_completar(mision: MisionNode):
	# Condiciones personalizadas para cada misión
	if mision.nombre == "Construye un edificio" and check_if_building_is_complete():
		return true
	elif mision.nombre == "Destruye un edificio" and check_if_building_is_destroyed():
		return true
	elif mision.nombre == "Crea una jaula" and check_if_cage_is_built():
		return true
	elif mision.nombre == "Compra un dinosaurio" and check_if_dinosaur_is_bought():
		return true
	elif mision.nombre == "Crea un edificio especial" and check_if_special_building_is_built():
		return true
	elif mision.nombre == "Compra dos especies" and check_if_two_species_are_bought():
		return true
	elif mision.nombre == "Evoluciona un dinosaurio" and check_if_dinosaur_is_evolved():
		return true

func check_if_building_is_complete():
	if Global.buildings>=1:
		return true

func check_if_building_is_destroyed():
	if estructura.lista_edificio.tamaño_lista()<Global.buildings:
		return true  # Simulación de que aún no se cumple

func check_if_cage_is_built():
	if Global.dinos.size()>0:
		return true  # Simulación de que la condición aún no se cumple

func check_if_dinosaur_is_bought():
	if Global.dinos.size()>0:
		return true  # Simulación de que la condición aún no se cumple

func check_if_special_building_is_built():
	if Global.building_id == 5 or Global.building_id == 14:
		return true  # Simulación de que la condición aún no se cumple

func check_if_two_species_are_bought():
	if Global.dinos.size()>2:
		for i in Global.dinos:
			if i != i+1:
				return true

func check_if_dinosaur_is_evolved():
	if Global.dinos_evo.size()>0:
	# Lógica para comprobar si un dinosaurio ha evolucionado
		return true  # Simulación de que aún no se cumple


func _on_mision_pressed():
	verificar_misiones(raiz_mision)
	actualizar_mision_visual(raiz_mision)
