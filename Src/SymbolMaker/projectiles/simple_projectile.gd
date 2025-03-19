extends Node2D

# Called every frame. 'deltaextends Node2D
@export var length: int
@export var velocity: float
@export var heading: float
var RADIUS = 20
var caught = false
signal captured(point)
signal entered(point, area)
var area = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	self.position += Vector2(0,1).rotated(heading) * (velocity * delta)

		
	pass


func init():
	$AnimatedSprite2D.play()
	pass


func check_if_captured():
	for line in get_tree().get_nodes_in_group("visual_lines"):
		line.queue_free()
	var polygon = area.get_child(0)
	if polygon.is_class("CollisionPolygon2D"):
		var point_count = polygon.polygon.size()
		var a = null
		var b = null
		var dist = null
		var min_dist = 10000
		var minpointa = null
		var minpointb = null
		for i in range(point_count):
			var new_line = Line2D.new()
			a = polygon.polygon[i]
			b = polygon.polygon[(i+1)%point_count]
			var closest_point = Geometry2D.get_closest_point_to_segment($Area2D/CollisionShape2D2.position,a,b)
			new_line.add_point(closest_point)
			new_line.add_point($Area2D/CollisionShape2D2.position)
			new_line.add_to_group('visual_lines')
			self.add_child(new_line)
			
			
			dist = closest_point.distance_to(self.position)
			if dist < min_dist:
				min_dist = dist
				minpointa = a
				minpointb = b
			
			if dist < 20:
				print(min_dist)
				return 
		captured.emit(self)
		#self.queue_free()
	pass # Replace with function body.
	
func is_captured():
	velocity = 0
	$AnimatedSprite2D.animation = 'caught'
	caught = true	
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('KILLBOX'):
		self.queue_free()
	elif !area.is_in_group('projectile'):
		print('entered')
		entered.emit(self,area)
		if self.area == null:
			self.area = area
		pass
		


func _on_area_2d_area_exited(area: Area2D) -> void:
	self.area = null


func _on_animated_sprite_2d_animation_finished() -> void:
	if caught:
		queue_free()
	pass # Replace with function body.
