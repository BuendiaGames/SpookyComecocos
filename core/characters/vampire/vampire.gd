extends CharacterBody3D

#Velocidad de movimiento del vampiro
const speed = 250.0

const threshold_direct = 2

#Maquina de estados. El vampiro puede estar cazando o teletransportarse.
#Mientras se teletransporta se queda parado en el sitio durante un ratito.
enum {CHASE, TELEPORT}
var state = CHASE

#Referencias al jugador y los teletransportadores
var player = null
var teleporters = null

#Variables de timer cortas para el tiempo de espera durante la teletransportacion
var elapsed_time = 0.
var teleported = false
const wait_time = 0.75
const resume_time = 1.0

#Coge las instancias del jugador y teletransprtadores
func _ready() -> void:
	add_to_group("monstruos")
	player = get_tree().get_first_node_in_group("player")
	teleporters = get_tree().get_nodes_in_group("teleporters")
	$main_mesh/AnimationPlayer.play("walk")
	
	randomize()
	$teleport.start(randf() * 20.0)


func _physics_process(delta: float) -> void:
	#Mientras estamos cazando...
	if state == CHASE:
		if position.distance_squared_to(player.position) > threshold_direct:
			#Mirar si hemos llegado al punto de destino
			if not $nav.is_navigation_finished():
				#Coge la direccion a la proxima pista del navmesh, hacia el jugador
				var direction = $nav.get_next_path_position() - position
				direction.y = 0. 
				
				velocity = delta * speed * direction.normalized()
				
				#Rotacion hacia donde esta andando
				var look_direction = Vector2(velocity.z, velocity.x)
				$main_mesh.rotation.y = look_direction.angle()
				
				#Mover y colisionar
				move_and_slide()
			#Una vez hemos llegado, actualizar de nuevo la posicion del player
			else:
				$nav.target_position = player.position
				
		else:
			var direction = player.position - position
			velocity = delta * speed * direction.normalized()
			
			#Rotacion hacia donde esta andando
			var look_direction = Vector2(velocity.z, velocity.x)
			$main_mesh.rotation.y = look_direction.angle()
			
			#Mover y colisionar
			move_and_slide()
	else:
		#Estamos esperando durante la teletransportacion
		elapsed_time += delta 
		
		#Esperar un poco antes de teletransportar para hacer una animacion
		#TODO bomba de humo
		if elapsed_time >= wait_time && not teleported:
			#Elegir un teletransportador al azar
			var index = randi_range(0, len(teleporters)-1)
			position = teleporters[index].position 
			teleported = true
		#Esperar un poquito tras teletransportarse y reinicar el estado de caza
		elif elapsed_time >= resume_time:
			$nav.target_position = player.position
			$teleport.start()
			$main_mesh/AnimationPlayer.play("walk")
			state = CHASE

#Actualizar la posicion del navigation agent para que caze al personaje
func _on_update_target_timeout() -> void:
	$nav.target_position = player.position

#Iniciar el estado de teletransportacion
func _on_teleport_timeout() -> void:
	$main_mesh/AnimationPlayer.play("idle")
	elapsed_time = 0.
	teleported = false
	state = TELEPORT
