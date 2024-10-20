extends Control

var showing_credits = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	#GameManager.load_game("res://core/levels/nivel1.tscn")
	GameManager.load_game("res://core/levels/laberinto_prueba.tscn")

func _on_credits_pressed() -> void:
	showing_credits = true
	$backgroundtext/columns/center/start.hide()
	$backgroundtext/columns/center/credits.hide()
	
	$backgroundtext/columns/center/credits_text.show()
	$backgroundtext/columns/center/back.show()

func _on_back_pressed() -> void:
	$backgroundtext/columns/center/start.show()
	$backgroundtext/columns/center/credits.show()
	
	$backgroundtext/columns/center/credits_text.hide()
	$backgroundtext/columns/center/back.hide()
	
