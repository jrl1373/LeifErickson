extends Node2D

var damaged = false
var flooded = false
var fire = false
var current_crew = null
var tile_atlas_coords = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update(sig):
	if sig == "damaged":
		damaged = true
