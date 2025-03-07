extends Node2D
signal snap(point) 
signal connected(point)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	snap.emit(self)
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	connected.emit(self)
	pass # Replace with function body.
