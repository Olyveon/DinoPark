extends Node
var mision_labels = {}
var all:Array=[cruce_mision,evoluciona_mision,compra_dos_especies_mision,crea_edificio_especial_mision,crea_jaula_mision,destruye_edificio_mision,compra_dinosaurio_mision,construye_edificio_mision]
var unlocked:Array=[]
var completed:Array=[]
var completed_first:Array=[]
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
var all_mision:Array=[cruce_mision,evoluciona_mision,compra_dos_especies_mision,crea_edificio_especial_mision,crea_jaula_mision,destruye_edificio_mision,compra_dinosaurio_mision,construye_edificio_mision]

func _ready():
	print("Juego iniciado")
	raiz_mision.desbloquear_mision()
	unlocked.append(raiz_mision)
	generar_labels_para_misiones(completed,unlocked)
	verificar_misiones(raiz_mision)
	limpiar_mision_container()


# Ejemplo de cómo se podría monitorizar el estado de las misiones
# Cada frame se comprueba si las condiciones de la misión se cumplen
#odrías tener una función que verifique si una misión debe completarse
func crear_listas():
	var new_mision:Array
	for i in all_mision:
		if i in unlocked or i in completed:
			pass
		if i in unlocked and i in completed:
			unlocked.erase(i)
		if condicion_para_completar(i)== true and i not in completed_first:
			completed_first.append(i)
		if condicion_para_completar(i)==true:
			for f in i.hijos:
				f.desbloquear_mision()
				unlocked.append(f)
			completed.append(i)
		else:
			pass
func limpiar_mision_container():
	var conteo=0
	for child in mision_container.get_children():
		child.queue_free()
		conteo+=1
	mision_container.call_deferred("free_children")  # Liberar todos los hijos
	if conteo> unlocked.size()+completed.size():
		var labels_totales= unlocked.size()+completed.size()
		for child in mision_container.get_children():
			pass

func generar_labels_para_misiones(completed: Array, unlocked: Array):
	# Primero, limpiar el VBoxContainer para evitar duplicaciones
	limpiar_mision_container()

	# Crear labels en verde para las misiones completadas
	for mision in completed:
		var label = Label.new()
		label.text = mision.nombre  # Asigna el nombre de la misión
		label.modulate=Color(0, 1, 0, 1)  # Color verde para misiones completadas
		mision_container.add_child(label)  # Agregar el label al VBoxContainer

	# Crear labels en gris para las misiones desbloqueadas
	for mision in unlocked:
		var label = Label.new()
		label.text = mision.nombre  # Asigna el nombre de la misión
		label.modulate=Color(1, 1, 1, 0.5)  # Color gris para misiones desbloqueadas
		mision_container.add_child(label)  # Agregar el label al VBoxContainer

# Función para mostrar las misiones en el panel
# Función para mostrar las misiones en el panel
func mostrar_misiones(mision: MisionNode):
	pass


# Función para actualizar el estado visual de las misiones
func actualizar_mision_visual(mision: MisionNode):
	limpiar_mision_container()
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
	limpiar_mision_container()
	print("Verificando misión:", mision.nombre)  # Mensaje de depuración

	# Verifica si la misión ya está completada
	if mision.completada:
		print("Misión ya completada:", mision.nombre)
		return true  # Mensaje de depuración
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
	var tamaño=Global.dinos.size()
	if Global.dinos.size()>2:
		for i in range(0,tamaño-1):
			if Global.dinos[i] != Global.dinos[i+1]:
				return true

func check_if_dinosaur_is_evolved():
	if Global.dinos_evo.size()>0:
	# Lógica para comprobar si un dinosaurio ha evolucionado
		return true  # Simulación de que aún no se cumple


func _on_mision_pressed():
	unlocked=[construye_edificio_mision]
	completed=[]
	crear_listas()
	for i in unlocked:
		if i in unlocked and i in completed:
			unlocked.erase(i)
		if i in completed and completed_first:
			pass
	generar_labels_para_misiones(completed_first,unlocked)
