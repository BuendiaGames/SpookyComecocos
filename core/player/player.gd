extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var current_anim = "idle"

func _ready() -> void:
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

func change_anim(new_anim):
	if current_anim != new_anim:
		current_anim = new_anim
		$model/AnimationPlayer.play(new_anim)
