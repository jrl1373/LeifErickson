extends Node2D
@export var length: int
@export var velocity: float
@export var heading: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	self.position += Vector2(0,-1).rotated(deg_to_rad(heading)) * (velocity * delta)
	pass


func init():
	var line = Line2D.new()
	var collision = RectangleShape2D.new()
	collision.size.x = length
	collision.size.y = 10
	line.width = 10
	line.add_point(Vector2(-length/2,0))
	line.add_point(Vector2(length/2,0))
	self.add_child(line)
	self.rotate(deg_to_rad(heading))
	$Area2D/CollisionShape2D.shape = collision
