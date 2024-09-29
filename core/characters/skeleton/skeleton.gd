extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

const TIMER = 2

var random_x = 0
var random_y = 0

var contador = 0
var esta_parado = true

var rng = RandomNumberGenerator.new()
	

func _ready() -> void:
	#Animacion
	add_to_group("monstruos")
	$model/AnimationPlayer.play("idle")

func _process(delta: float) -> void:	
	if contador > TIMER:
		random_x = rng.randf_range(-10.0, 10.0)
		random_y = rng.randf_range(-10.0, 10.0)
		
		contador = 0
		
		#Animacion
		if esta_parado:
			$model/AnimationPlayer.play("walk")
			esta_parado = false
		
	#Rotar nuestro input en la direccion
	var direction = Vector3(random_x, 0, random_y)
	
	#Normalizar velocidad (evita diagonales mas rapidas)
	velocity = direction.normalized() * SPEED
	
	#Obtener el angulo de la velocidad para poner el muñeco mirando a donde debe 
	var look_direction = Vector2(velocity.z, velocity.x)
	$model.rotation.y = look_direction.angle()
	
	# Incrementa el contador de tiempo
	contador += delta
	
	#Haz el movimiento
	move_and_slide()
	
	
