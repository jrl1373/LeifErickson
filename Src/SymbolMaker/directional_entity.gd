class_name Moveable
extends Node2D
var velocity: float
var heading: float
var lerperClass = preload("res://Src/Utilities/Lerper.gd")
var lerper = null
func set_lerp(end = self.position,duration = 1,start = self.position):
	lerper = Lerper.new()
	lerper.init(start,end,duration)
	self.add_child(lerper)
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
