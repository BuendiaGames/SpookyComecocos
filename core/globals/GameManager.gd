extends Node

#Calabazas recogidas de momento
var collected_pumpkins = 0
var ui = null
var tiempo = 0

var joystick_activado = false

#Escena actual. Tendra que ser el menu. #TODO
var current_scene = null

var musicplayer = null
var sfxplayer = null
var currentsfx = null

func _ready() -> void:
	musicplayer = AudioStreamPlayer.new()
	add_child(musicplayer)
	
	sfxplayer = AudioStreamPlayer.new()
	sfxplayer.max_polyphony = 4
	sfxplayer.volume_db = 2
	add_child(sfxplayer)
	
	play_background_song("menu")
	
	set_process(false)
	set_physics_process(false)
	

func play_sound(sound):
	if sound != currentsfx:
		sfxplayer.stream = load("res://sfx/"+sound+".wav")
	sfxplayer.play()


func play_background_song(name):
	musicplayer.stop()
	musicplayer.stream = load("res://music/spooky_"+name+".ogg")
	musicplayer.play()

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
	
