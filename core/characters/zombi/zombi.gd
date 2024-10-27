extends CharacterBody3D

#Velocidad de movimiento del vampiro
const speed = 75.0
const threshold_direct = 2


#Referencias al jugador
var player = null

#Coge las instancias del jugador y teletransprtadores
func _ready() -> void:
	add_to_group("monstruos")
	player = get_tree().get_first_node_in_group("player")
	
	$main_mesh/AnimationPlayer.play("walk")


func _process(delta: float) -> void:
	#Comprueba si tenemos que seguir andando o hemos acabado y hay que 
	#coger de nuevo la posicion del jugador
	if position.distance_squared_to(player.position) > threshold_direct:
		#Mirar si hemos llegado al punto de destino
		if not $NavigationAgent3D.is_navigation_finished():
			#Coge la direccion a la proxima pista del navmesh, hacia el jugador
			var direction = $NavigationAgent3D.get_next_path_position() - position
			direction.y = 0. 
			velocity = delta * speed * direction.normalized()
			
			#Rotacion hacia donde esta andando
			var look_direction = Vector2(velocity.z, velocity.x)
			$main_mesh.rotation.y = look_direction.angle()
			
			#Mover y colisionar
			move_and_slide()
		else:
			$NavigationAgent3D.target_position = player.position
	else:
		var direction = player.position - position
		velocity = delta * speed * direction.normalized()
		
		#Rotacion hacia donde esta andando
		var look_direction = Vector2(velocity.z, velocity.x)
		$main_mesh.rotation.y = look_direction.angle()
		
		#Mover y colisionar
		move_and_slide()

func _on_update_target_timeout() -> void:
	$NavigationAgent3D.target_position = player.position
	
