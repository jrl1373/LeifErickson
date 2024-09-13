extends Node2D
var TILE_SIZE = 16



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if Input.is_action_just_pressed("click"):
		var cell = floor(get_local_mouse_position()/16)

		
	pass
