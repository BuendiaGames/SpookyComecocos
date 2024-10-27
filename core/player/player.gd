extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var current_anim = "idle"

var tiene_llave = false

var nodo_ui = null

func _ready() -> void:
	nodo_ui = get_tree().get_first_node_in_group("nodo_ui")
	
	add_to_group("player")
	change_anim(current_anim)


func _process(delta: float) -> void:
	#Vector (x,y) con la direccion de las flechas. Con un joystick es continua
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	#Si pulsamos algo, input_dir !=0 y andamos
	if input_dir:
		#Rotar nuestro input en la direccion
		var direction = Vector3(input_dir.x, 0, input_dir.y)
		
		#Normalizar velocidad (evita diagonales mas rapidas)
		velocity = direction.normalized() * SPEED
		
		#Obtener el angulo de la velocidad para poner el muñeco mirando a donde debe 
		var look_direction = Vector2(velocity.z, velocity.x)
		$model.rotation.y = look_direction.angle()
		
		#Animacion
		change_anim("walk")
	else:	
		#Elimina la velocidad
		velocity.x = 0.0
		velocity.z = 0.0
		change_anim("idle")
	
	#Haz el movimiento
	move_and_slide()
	
	# Cuento el tiempo
	GameManager.tiempo += delta

func change_anim(new_anim):
	if current_anim != new_anim:
		current_anim = new_anim
		$model/AnimationPlayer.play(new_anim)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("monstruos"):
		GameManager.defeat()
		print(body.name)
	

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("calabazas"):
		GameManager.play_sound("pumpkin")
		GameManager.collect_pumpkin()
		area.emit_effect_and_kill()
		#area.queue_free()
	elif area.is_in_group("llave"):
		GameManager.play_sound("key")
		area.emit_effect_and_kill()
		tiene_llave = true
		var mausoleito = get_tree().get_first_node_in_group("mausoleos")
		mausoleito.abrir_y_cerrar_puerta()
		nodo_ui.show_key()
