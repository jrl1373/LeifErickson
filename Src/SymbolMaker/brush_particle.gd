extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TestParticle.emitting = true;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func rotate_particle(heading):
	self.rotate(heading)
	

func _on_test_particle_finished() -> void:
	self.queue_free()
	pass # Replace with function body.
