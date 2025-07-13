extends Node2D
var point = preload("res://Src/SymbolMaker/Point.tscn")
var circle = preload("res://Src/SymbolMaker/Symbols/Circle.tscn")
var wall = preload("res://Src/SymbolMaker/Symbols/Wall.tscn")
var magic_circle = preload("res://Src/SymbolMaker/Pentagon.tscn")
var can_draw = false
var current_line = null
var current_points = null
var point_distance = 40
var current_point_distance = 0
var last_point = null
var collision_points = [null,null]
var max_energy = 10000
var energy = 10000
var energy_per_second = 20000;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_energy(energy_per_second * delta)
	#if collision_points != [null,null]:
		#collision_points = [null,null]
	
	pass
	
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventKey:	
		if event.is_action_pressed("toggle_draw"):
			if current_line:
				var points = sort_outermost_by_index(find_outermost_points_in_sectors(current_line))
				var pentagrom = Line2D.new()
				for point in points:
					pentagrom.add_point(point.point)
				pentagrom.add_point(points[0].point)
				self.add_child(pentagrom)
					
					
					
					
				#create_wall(current_line)
				current_line = null
				current_points = null
			can_draw = !can_draw 
			print(can_draw)
			for child in $Points.get_children():
				child.queue_free()
			for child in $Line.get_children():
				child.queue_free()
		if event.is_action_pressed("submit"):
			for child in $Points.get_children():
				child.queue_free()
			for child in $Circles.get_children():
				child.queue_free()
			for child in $Line.get_children():
				child.queue_free()
		if event.is_action_pressed("create_circle"):
			var new_magic_circle = magic_circle.instantiate()
			new_magic_circle.position = get_local_mouse_position()
			self.add_child(new_magic_circle)

	if event is InputEventMouseMotion:
		var mouse_pos = get_local_mouse_position()
		if can_draw:
			if !current_line:
				current_line = Line2D.new()
				current_points = PackedVector2Array()
				last_point = mouse_pos
				$Line.add_child(current_line)
			else:
				current_point_distance += mouse_pos.distance_to(last_point)
				print(current_point_distance)
				if current_point_distance < energy:
					current_line.add_point(mouse_pos)
					change_energy(-1*current_point_distance)
					last_point = mouse_pos
					if current_point_distance > point_distance:
						current_point_distance = 0
						var new_point = point.instantiate()
						new_point.connected.connect(snap_points)
						new_point.position = mouse_pos
						$Points.add_child(new_point)
						current_points.append(mouse_pos)			
						pass
				else:
					end_line()
		pass
		
func end_line():
	create_wall(current_line)
	current_line = null
	can_draw = false
	
	
func create_wall(line):
	var new_wall = wall.instantiate()
	$Line.remove_child(line)

	new_wall.init(line)
	self.add_child(new_wall)
	pass	
	
func change_energy(delta):
	energy = min(max_energy, energy + delta)
	$EnergyBar.value = energy
func clear_points():
	for point in $Points.get_children():
		point.queue_free()
func snap_points(point):
	return
	if current_points:
		if collision_points[0] == null:
			collision_points[0] = current_points.find(point.position)
			print(collision_points)
		else:
			can_draw = false
	#		find the location of the two points connected
			collision_points[1] = current_points.find(point.position)
			collision_points.sort()

			var polygon = current_points.slice(collision_points[0],collision_points[1])
			var new_circle = circle.instantiate()
			new_circle.init(polygon,current_line.points)
					
			$Circles.add_child(new_circle)
			$Line.remove_child(current_line)
			print(collision_points)
			collision_points = [null,null]
			clear_points()
	print("snapping success")
	
	
func find_center(line):
	var point_sum = Vector2(0,0)
	for point in line.points:
		point_sum += point
	var center = point_sum/line.points.size()
	return center
	
func find_outermost_points_in_sectors(line: Line2D) -> Array:
	if line.get_point_count() == 0:
		return []
	
	var center = find_center(line)
	var sectors = 5
	var sector_angle = 2 * PI / sectors  # 72 degrees in radians
	var outermost_points = []
	
	# Initialize array to store the farthest point in each sector
	for i in range(sectors):
		outermost_points.append({"point": Vector2.ZERO, "distance": -1, "index": -1})
	
	# Check each point in the line
	for i in range(line.get_point_count()):
		var point = line.get_point_position(i)
		var relative_pos = point - center
		
		# Skip if point is at center
		if relative_pos.length() == 0:
			continue
		
		# Calculate angle from center to point (0 to 2π)
		var angle = atan2(relative_pos.y, relative_pos.x)
		if angle < 0:
			angle += 2 * PI
		
		# Determine which sector this point belongs to
		var sector_index = int(angle / sector_angle)
		if sector_index >= sectors:  # Handle edge case for 2π
			sector_index = sectors - 1
		
		# Calculate distance from center
		var distance = relative_pos.length()
		
		# Update if this is the farthest point in this sector
		if distance > outermost_points[sector_index]["distance"]:
			outermost_points[sector_index]["point"] = point
			outermost_points[sector_index]["distance"] = distance
			outermost_points[sector_index]["index"] = i
	
	return outermost_points
	
	
	
func sort_outermost_by_index(outermost_points: Array) -> Array:
# Filter out sectors with no points (index = -1)
	var valid_points = []
	for point_data in outermost_points:
		if point_data["index"] != -1:
			valid_points.append(point_data)

	# Sort by index
	valid_points.sort_custom(func(a, b): return a["index"] < b["index"])

	return valid_points
				

		
		
