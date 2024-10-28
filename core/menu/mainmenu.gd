extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	#GameManager.load_game("res://core/levels/nivel1.tscn")
	GameManager.play_sound("menu")
	GameManager.play_background_song("main")
	GameManager.load_game("res://core/levels/nivel1.tscn")

func _on_credits_pressed() -> void:
	GameManager.play_sound("menu")
	
	$backgroundtext/columns/center/start.hide()
	$backgroundtext/columns/center/credits.hide()
	$backgroundtext/columns/center/howtoplay.hide()
	$backgroundtext/columns/center/controls.hide()
	$backgroundtext/columns/center/activ_joystick.hide()
	
	$backgroundtext/columns/center/credits_text.show()
	$backgroundtext/columns/center/back.show()

func _on_back_pressed() -> void:
	GameManager.play_sound("menu")

	
	$backgroundtext/columns/center/start.show()
	$backgroundtext/columns/center/credits.show()
	$backgroundtext/columns/center/howtoplay.show()
	$backgroundtext/columns/center/controls.show()

	
	$backgroundtext/columns/center/credits_text.hide()
	$backgroundtext/columns/center/howtoplay_text.hide()
	$backgroundtext/columns/center/back.hide()
	$backgroundtext/columns/center/controls_text.hide()
	$backgroundtext/columns/center/controls_text2.hide()
	$backgroundtext/columns/center/activ_joystick.hide()

	

func _on_howtoplay_pressed() -> void:
	
	GameManager.play_sound("menu")

	
	$backgroundtext/columns/center/start.hide()
	$backgroundtext/columns/center/credits.hide()
	$backgroundtext/columns/center/howtoplay.hide()
	$backgroundtext/columns/center/controls.hide()
	$backgroundtext/columns/center/activ_joystick.hide()
	
	
	$backgroundtext/columns/center/howtoplay_text.show()
	$backgroundtext/columns/center/back.show()
	pass # Replace with function body.


func _on_controls_pressed() -> void:
	GameManager.play_sound("menu")
	
	var texto = "Joystick is currently deactivated."
	var texto_boton = "Activate joystick"
	if GameManager.joystick_activado:
		texto = "Joystick is currently activated."
		texto_boton = "Deactivate joystick"
	else:
		texto = "Joystick is currently deactivated."
		texto_boton = "Activate joystick"
		
	$backgroundtext/columns/center/controls_text2.text = texto
	$backgroundtext/columns/center/activ_joystick.text = texto_boton
		
	$backgroundtext/columns/center/start.hide()
	$backgroundtext/columns/center/credits.hide()
	$backgroundtext/columns/center/howtoplay.hide()
	$backgroundtext/columns/center/controls.hide()
	
	$backgroundtext/columns/center/controls_text.show()
	$backgroundtext/columns/center/controls_text2.show()
	
	$backgroundtext/columns/center/activ_joystick.show()
	$backgroundtext/columns/center/back.show()
	pass # Replace with function body.


func _on_activ_joystick_pressed() -> void:
	GameManager.play_sound("menu")
	
	var texto = "Joystick is currently deactivated."
	var texto_boton = "Activate joystick"
	
	GameManager.joystick_activado = !GameManager.joystick_activado
	
	if GameManager.joystick_activado:
		texto = "Joystick is currently activated."
		texto_boton = "Deactivate joystick"
	else:
		texto = "Joystick is currently deactivated."
		texto_boton = "Activate joystick"
		
	$backgroundtext/columns/center/controls_text2.text = texto
	$backgroundtext/columns/center/activ_joystick.text = texto_boton

	pass # Replace with function body.
