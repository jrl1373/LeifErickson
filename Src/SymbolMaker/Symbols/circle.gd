extends Node2D

var lifespan = 0
var expires = true
var debugging = false
#creates a circle, imports polygon and points of line from drawing node
func init(polygon,points) -> void:
	$Area2D/CollisionPolygon2D.polygon = polygon
	$Line2D.points = points
	lifespan = 10/sqrt(polygon.size())
	$Timer.wait_time = lifespan
	pass


func check_collision(point):
	point.add_to_group('points')
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if expires:
		$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for point in get_tree().get_nodes_in_group('points'):
		check_if_captured(point)
		
	pass
	
#For some reason this only works if debuggin is set to true,
#you comment out all of the debugging logic, and you pass both if statements
#even adding print statements seems to break this, come back later to figure out what is happening.
#I am afraid to even remove the extra blank lines, for they may be vitally important.
func check_if_captured(point):
	
	if debugging:
		for line in get_tree().get_nodes_in_group("visual_lines"):
			line.queue_free()
		pass
	var polygon = $Area2D/CollisionPolygon2D
	if polygon.is_class("CollisionPolygon2D"):
		var point_count = polygon.polygon.size()
		var a = null
		var b = null
		var dist = null
		var min_dist = 10000
		var minpointa = null
		var minpointb = null
		for i in range(point_count):
			a = polygon.polygon[i]
			b = polygon.polygon[(i+1)%point_count]
			var closest_point = Geometry2D.get_closest_point_to_segment(point.position,a,b)
			if debugging:
				var new_line = Line2D.new()
				new_line.add_point(closest_point)
				new_line.add_point(point.position)
				new_line.add_to_group('visual_lines')
				self.add_child(new_line)
				pass
			
			
			dist = closest_point.distance_to(point.position)
			if dist < min_dist:
				min_dist = dist
				minpointa = a
				minpointb = b
			
			if dist < 63.2:
				print(min_dist)
				return 
		point.remove_from_group('points')
		point.queue_free()

		#self.queue_free()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	print("exiting!")
	self.queue_free()
	pass # Replace with function body.
