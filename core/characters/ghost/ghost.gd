extends CharacterBody3D

#Velocidad del fantasma
const SPEED = 0.1

#El objeto pathfollow
var ghostpath = null

#Coger el pathfollow que es siempre el padre del fantasma
func _ready() -> void:
	ghostpath = get_parent()
	$main_mesh/AnimationPlayer.play("walk")

#Sencillamente avanzar en el pathfollow
func _process(delta: float) -> void:
	ghostpath.progress_ratio += SPEED * delta
	move_and_slide()
