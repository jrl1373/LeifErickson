extends Node2D

signal selected(cannon)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot():
	$Sprite.play()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		print("Selected!")
		selected.emit(self)
		
	pass # Replace with function body.