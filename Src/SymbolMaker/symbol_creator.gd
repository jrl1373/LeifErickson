extends Node2D
@export var point: PackedScene
@export var brushParticle: PackedScene
@onready var _lines: Node2D = $Line2D
var held = false
var _currentline: Line2D = null
var line: Line2D = null
# Called when the node enters the scene tree for the first time.

func add_point(event):
	var new_point = point.instantiate()
	new_point.position = event.position
	new_point.snap.connect(snap_line)
	$Lines.add_child(new_point)
	
	
func snap_line(point):
	if line:
		line.set_point_position(1,point.position)

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:	
		print("Mouse Click/Unclick at: ", event.position)
		if event.is_action_pressed("click"):
			if line != null:
				line.add_point(event.position)
			line = Line2D.new()
			line.default_color = Color('Green')
			add_point(event)
			line.add_point(event.position)
			line.add_point(event.position)
			$Lines.add_child(line)
			
		if event.is_action_pressed("deselect"):
			if line:
				line.remove_point(1)
				line = null
	elif event is InputEventMouseMotion:
		var velocity = event.get_velocity()
		print("Mouse velocity: ", velocity)
		var particle = brushParticle.instantiate()
		particle.rotate_particle(velocity.angle()+ PI)
		particle.position = event.position
		$CursorParticles.add_child(particle)
		
		
	
		if line != null:
			line.set_point_position(1,event.position)
