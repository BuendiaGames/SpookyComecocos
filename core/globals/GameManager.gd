extends Node

#Calabazas recogidas de momento
var collected_pumpkins = 0
var ui = null
var tiempo = 0

#Escena actual. Tendra que ser el menu. #TODO
var current_scene = null

func _ready() -> void:
	set_process(false)
	set_physics_process(false)

#Permite saber al GameManager la existencia de nuestra UI para poder actualizarla
func link_to_ui(ui_nodo : Control):
	ui = ui_nodo

#Aumenta el numero de calabazas y actualiza la UI
func collect_pumpkin():
	collected_pumpkins += 1
	ui.set_pumpkin_counter(collected_pumpkins)

func load_game(level):
	get_tree().change_scene_to_file(level)

func load_menu():
	get_tree().paused = false
	resetear_valores()
	get_tree().change_scene_to_file("res://core/menu/mainmenu.tscn")

func victory():
	get_tree().paused = true
	ui.show_results(true)

func defeat():
	get_tree().paused = true 
	ui.show_results(false)
	
func resetear_valores():
	collected_pumpkins = 0
	tiempo = 0
	
