extends Node2D

# Called every frame. 'deltaextends Node2D
@export var length: int
@export var velocity: float
@export var heading: float
var RADIUS = 63
signal captured(point)
var area = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	self.position += Vector2(0,1).rotated(heading) * (velocity * delta)
	if area != null:
		check_if_captured()
		
	pass


func init():
	pass


func check_if_captured():
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
			a = polygon.polygon[i]
			b = polygon.polygon[(i+1)%point_count]
			dist = Geometry2D.get_closest_point_to_segment(self.position,a,b).distance_to(self.position)
			if dist < min_dist:
				min_dist = dist
				minpointa = a
				minpointb = b
			
			if dist < 63.2:
				print(min_dist)
				return 
		captured.emit(self)
		self.queue_free()
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	print('entered')
	pass
	


func _on_area_2d_area_exited(area: Area2D) -> void:
	if self.area == null:
		self.area = area
	else:
		self.area = null
