extends Node2D
@export var simple_projectile: PackedScene
@export var enemy: PackedScene
@export var scene: PackedScene
var SPAWN_DISTANCE = 1000
var collisions = []
var total_entered = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_child(scene.instantiate())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_projectile_timer_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group('enemies')
	if enemies.size() != 0:
		var idx = randi_range(0,enemies.size()-1)
		var picked_enemy = enemies[idx]
		
		var new_projectile = simple_projectile.instantiate()
		var angle = randf_range(0,2*PI)
		var spawn_location = Vector2(0,-1).rotated(angle) * SPAWN_DISTANCE
		print(picked_enemy.position)
		new_projectile.position = picked_enemy.position
		new_projectile.heading = angle
		new_projectile.velocity = randi_range(100,150)
		new_projectile.captured.connect(captured)
		new_projectile.entered.connect(entered)
		self.add_child(new_projectile)
	else:
		print('empty!')

	
	
	pass # Replace with function body.
	
	
func captured(point):
	print("captured!")
	pass
	
func entered(point, area):
	for circle in $DrawingNode/Circles.get_children():
		if circle.get_child(0) == area:
			circle.check_collision(point)
			



func _on_tree_entered() -> void:
	total_entered += 1
	print("entered:", total_entered)
	pass # Replace with function body.


func _on_waddler_timer_timeout() -> void:
	var new_enemy = enemy.instantiate()
	var angle = randf_range(0,2*PI)
	var spawn_location = Vector2(0,-1).rotated(angle) * SPAWN_DISTANCE
	new_enemy.position = spawn_location
	new_enemy.heading = angle
	new_enemy.velocity = randi_range(50,75)
	new_enemy.add_to_group('enemies')
	self.add_child(new_enemy)
	
	pass # Replace with function body.
