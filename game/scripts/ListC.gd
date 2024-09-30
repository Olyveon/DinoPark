extends Node
func _ready():
	var lista_edificios = ListaEnlazada.new()

class Nodo:
	var valor: String
	var siguiente = null

	func _init(valor: String):
		self.valor = valor

	func __str__() -> String:
		return "Edificio ID: " + valor

class ListaEnlazada:
	var cabeza = null
	var tamaño = 0

	func agregar(valor:String):
		var nuevo_nodo = Nodo.new(valor)
		if cabeza == null:
			cabeza = nuevo_nodo
		else:
			var actual = cabeza
			while actual.siguiente != null:
				actual = actual.siguiente
			actual.siguiente = nuevo_nodo
		tamaño += 1
		

	func eliminar(valor):
		if cabeza == null:
			return
		if cabeza.valor == valor:
			cabeza = cabeza.siguiente
			tamaño -= 1
			return
		var actual = cabeza
		while actual.siguiente != null:
			if actual.siguiente.valor == valor:
				actual.siguiente = actual.siguiente.siguiente
				tamaño -= 1
				return
			actual = actual.siguiente

	func tamaño_lista():
		return tamaño

	func existe_edificio_tipo1():
		var actual = cabeza
		while actual != null:
			if actual.valor == "0":
				return true
			actual = actual.siguiente
		return false

	func mostrar_lista():
		var actual = cabeza
		while actual != null:
			print(actual.__str__())
			actual = actual.siguiente

	func __str__():
		var resultado = ""
		var actual = cabeza
		while actual != null:
			resultado += actual.__str__() + "\n"
			actual = actual.siguiente
		return resultado

var lista_edificio = ListaEnlazada.new()
var estructura_desbloqueada = false


func seleccionar_edificio(edificio_id):
	if lista_edificio.tamaño_lista() == 1 :
		mostrar_alerta()
		return false 
	if lista_edificio.tamaño_lista() > 2:
		
		return true
	print(str(lista_edificio.tamaño_lista()))
	print("Edificio seleccionado: " + edificio_id)


func mostrar_alerta():
	print("nao")
   

func mostrar_lista_edificios():
	print("Edificios seleccionados: ")
	print(lista_edificio.__str__())
