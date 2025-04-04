class_name Lerper
extends Node

var start = null
var end = null
var current = 0
var duration = null
var position = null
func init(start,end,duration):
	self.start = start
	self.position = start
	self.end = end
	self.duration = duration
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = lerp(start,end,current)
	current = min(current + delta/duration,1)
	if current >=1:
		self.queue_free()
	pass
