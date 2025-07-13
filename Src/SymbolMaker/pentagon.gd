extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_circle()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
	
func create_circle():
	$MagicCircle.play()
