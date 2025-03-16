extends Moveable


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position += Vector2(0,1).rotated(heading) * (velocity * delta)
	pass
	
	
func start():
	$AnimatedSprite2D.play()
func stop():
	$AnimatedSprite2D.stop()
func set_animation(animation):
	$AnimatedSprite2D.animation = animation
