extends Node2D
var helpfulpirate = ["
Wecome travelers. See anything you like?", "
I got this one from my boarding school years on the old SS Trumpet","
Alright get out."]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialogue.newlist(helpfulpirate)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
