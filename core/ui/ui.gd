extends Control
var max_pumpkins = 0

func _ready() -> void:
	#Esconder la llave que no esta disponible al principio
	$margen/container/key.hide()
	#Inicializar el contador de calabazas
	max_pumpkins = compute_number_pumpkins()
	$margen/container/label.text = "0 / " + str(max_pumpkins)
	
	#Tell the game manager that we exists
	GameManager.link_to_ui(self)
	
	#This node needs no procesing
	set_process(false)
	set_physics_process(false)

#Obtiene el numero total de calabazas coleccionables en el nivel
func compute_number_pumpkins():
	return get_tree().get_node_count_in_group("calabazas")

#Modifica el contador de calabazas
func set_pumpkin_counter(n_pumpkins : int):
	$margen/container/label.text = str(n_pumpkins) + " / " + str(max_pumpkins)

func show_key():
	$margen/container/key.show()
