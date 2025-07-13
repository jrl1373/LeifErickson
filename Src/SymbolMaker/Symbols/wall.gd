extends Node2D
var full_wall = preload("res://Assets/Brush/brush2.png")
var damaged_wall = preload("res://Assets/Brush/brush2b.png")
var line = null
func init(line) -> void:
	line.texture = full_wall
	line.width = 100
	line.texture_mode = 1
	self.add_child(line)
	self.line = line
	for i in range(1,line.points.size()):
		var shape = CollisionShape2D.new()
		var segment = SegmentShape2D.new()
		segment.a = line.points[i-1]
		segment.b = line.points[i]
		shape.shape = segment
		$Area2D.add_child(shape)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	line.width -= 50 * delta
	pass


func _on_lifespan_timeout() -> void:
	self.queue_free()
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	var node = area.owner;
	if "is_projectile" in node:
		node.destroy()


func _on_damaged_timeout() -> void:
	if line:
		line.texture = damaged_wall
	pass # Replace with function body.
