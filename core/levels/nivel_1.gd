extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.joystick_activado:
		$Control/TouchControls.show()
		#$Control/TouchControls.process_mode = Node.PROCESS_MODE_ALWAYS

	else:
		$Control/TouchControls.hide()
		#$Control/TouchControls.process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
