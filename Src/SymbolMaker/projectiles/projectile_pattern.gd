extends Node2D
var bpm = 120
var projectile = preload("res://Src/SymbolMaker/projectiles/SimpleProjectile.tscn")
var startup = 2
var times = 3
var interval = .5
var total_times = 0

#projectile pattern (time, # of projectiles, projectile_type, split)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Startup.wait_time = startup
	$Interval.wait_time = interval
	$Startup.start()
	
		
		
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_projectile():
	var new_projectile = projectile.instantiate()
	new_projectile.initialize(100,0)
	self.add_child(new_projectile)

func _on_startup_timeout() -> void:
	$Interval.start()
	$Startup.stop()
	spawn_projectile()
	total_times +=1
	pass # Replace with function body.


func _on_interval_timeout() -> void:
	if total_times >= times:
		$Interval.stop()
	else:
		spawn_projectile()
		total_times += 1
	pass # Replace with function body.
