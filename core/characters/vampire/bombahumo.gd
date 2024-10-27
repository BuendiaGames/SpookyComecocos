extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$particles1.emitting = true 
	$particles2.emitting = true
	set_process(false)

func _on_particles_1_finished() -> void:
	queue_free()
