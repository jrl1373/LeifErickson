extends Node2D

@export var cannon: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	


func _on_ship_shot():
	
	var shot = cannon.instantiate()
	shot.position = $Ship.position
	shot.heading = $Ship.rotation
	add_child(shot)
	pass # Replace with function body.
