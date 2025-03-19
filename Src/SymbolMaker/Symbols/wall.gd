extends Node2D


func init(line) -> void:
	self.add_child(line)
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
	pass


func _on_lifespan_timeout() -> void:
	self.queue_free()
	pass # Replace with function body.
