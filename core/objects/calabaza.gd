extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)

func emit_effect_and_kill():
	$particles.emitting = true


func _on_particles_finished() -> void:
	queue_free()
