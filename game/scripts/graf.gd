extends Node

# Dictionary to represent the adjacency list
var grafo = {}

# Function to add a dinosaur (node) to the graph
func agregar_dinosaurio(dinosaurio: String) -> void:
	if not grafo.has(dinosaurio):
		grafo[dinosaurio] = []

# Function to add an edge (cross combination) between two dinosaurs
func agregar_cruce(dino1: String, dino2: String) -> void:
	if grafo.has(dino1) and grafo.has(dino2):
		grafo[dino1].append(dino2)  # Dino1 can cross with Dino2
		grafo[dino2].append(dino1)  # Dino2 can cross with Dino1 (undirected graph)

# Function to show the cross combinations (graph)
func mostrar_grafo() -> void:
	for key in grafo.keys():
		print(key + ": ")
		for cruce in grafo[key]:
			print(cruce + " ")
		print("\n")

# Function to get which dinosaurs a particular dinosaur can cross with
func obtener_cruces(dinosaurio: String) -> Array:
	if grafo.has(dinosaurio):
		return grafo[dinosaurio]
	return []

# Ready function for testing purpouses
func _ready() -> void:
	# Create the dinosaur graph
	agregar_dinosaurio("Tirannosaurio")
	agregar_dinosaurio("Triceratops")
	agregar_dinosaurio("Velociraptor")
	agregar_dinosaurio("Estegosaurus")
	agregar_dinosaurio("Parasaurio")
	agregar_dinosaurio("Espinosaurio")
	agregar_dinosaurio("Gigantosaurio")
	agregar_dinosaurio("Alosaurio")

	# Define the possible cross combinations (edges)
	agregar_cruce("Tyrannosaurus", "Velociraptor")
	agregar_cruce("Triceratops", "Stegosaurus")
	agregar_cruce("Tyrannosaurus", "Stegosaurus")

	# Show the cross combinations
	mostrar_grafo()

	# Consult which dinosaurs a specific dinosaur can cross with
	var cruces_de_tyrannosaurus = obtener_cruces("Tyrannosaurus")
	print("Tyrannosaurus puede cruzarse con: ")
	for cruce in cruces_de_tyrannosaurus:
		print(cruce + " ")
	print("\n")
