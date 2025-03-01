extends Node2D
var point = preload("res://Src/SymbolMaker/Point.tscn")
var can_draw = false
var current_line = null;
var current_points = null;
var point_distance = 40
var current_point_distance = 0
var last_point = null
var collision_points = [null,null]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	collision_points = [null,null]
	
	pass
	
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventKey:	
		if event.is_action_pressed("toggle_draw"):
			if current_line:
				current_line = null
				current_points = null
			can_draw = !can_draw 
			print(can_draw)
		if event.is_action_pressed("submit"):
			for child in $Points.get_children():
				child.queue_free()
			for child in $Circles.get_children():
				child.queue_free()
			for child in $Line.get_children():
				child.queue_free()

	if event is InputEventMouseMotion:
		var mouse_pos = get_local_mouse_position()
		if can_draw:
			if !current_line:
				current_line = Line2D.new()
				current_points = PackedVector2Array()
				last_point = mouse_pos
				$Line.add_child(current_line)
			else:
				current_line.add_point(mouse_pos)
				current_point_distance += mouse_pos.distance_to(last_point)
				last_point = mouse_pos
			if current_point_distance > point_distance:
				current_point_distance = 0
				var new_point = point.instantiate()
				new_point.connected.connect(snap_points)
				new_point.position = mouse_pos
				$Points.add_child(new_point)
				current_points.append(mouse_pos)			
				pass
		pass
		
		
func clear_points():
	for point in $Points.get_children():
		point.queue_free()
func snap_points(point):
	if current_points:
		if collision_points[0] == null:
			collision_points[0] = current_points.find(point.position)
			print(collision_points)
		else:
			can_draw = false
	#		find the location of the two points connected
			collision_points[1] = current_points.find(point.position)
			collision_points.sort()
			var new_area = Area2D.new()
			var new_col = CollisionPolygon2D.new()
			new_col.polygon = current_points.slice(collision_points[0],collision_points[1])
			new_area.add_child(new_col)
			$Circles.add_child(new_area)
			print(collision_points)
			collision_points = [null,null]
			clear_points()
	print("snapping success")

		
		
