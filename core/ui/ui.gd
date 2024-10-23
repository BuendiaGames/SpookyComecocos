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

func show_results(victory = true):
	if not victory:
		GameManager.play_background_song("defeat")
		$results/container_results/results.text = "You were caught!"
	else:
		GameManager.play_background_song("victory")
	$results/container_results/container/points.text= str(GameManager.collected_pumpkins)+"/"+str(max_pumpkins)
	var min_juego = int(GameManager.tiempo/60)
	var seg_juego = int(GameManager.tiempo)%60
	
	var cad_min_juego = str(min_juego)
	var cad_seg_juego = str(seg_juego)
	
	if min_juego < 10:
		cad_min_juego = "0" + cad_min_juego
	if seg_juego < 10:
		cad_seg_juego = "0" + cad_seg_juego
	
	$results/container_results/container2/points.text = cad_min_juego + ":" + cad_seg_juego
	
	$results.show()


func _on_back_pressed() -> void:
	GameManager.play_background_song("menu")
	GameManager.load_menu()
