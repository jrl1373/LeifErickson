extends Node2D
@export var simple_projectile: PackedScene
var SPAWN_DISTANCE = 1000


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_projectile_timer_timeout() -> void:
	print("spawning")
	var new_projectile = simple_projectile.instantiate()
	var angle = randf_range(0,2*PI)
	var spawn_location = Vector2(0,-1).rotated(angle) * SPAWN_DISTANCE
	new_projectile.position = spawn_location
	new_projectile.heading = angle
	new_projectile.velocity = randi_range(200,300)
	new_projectile.captured.connect(captured)
	self.add_child(new_projectile)

	
	
	pass # Replace with function body.
	
	
func captured(point):
	print("captured!")
	pass
