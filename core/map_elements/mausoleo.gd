extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("mausoleos")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func abrir_y_cerrar_puerta():
	$puerta/AnimationPlayer.play("open-and-close")


func _on_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if body.tiene_llave:
			$puerta/AnimationPlayer.play("open")
			GameManager.victory()
