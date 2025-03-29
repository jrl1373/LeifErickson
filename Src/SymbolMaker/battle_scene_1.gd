extends Node2D

var beat = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Waddler.visible = true
	$Waddler.set_lerp($WaddlerPoint.position)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#called every beat
func beat_process():
	if beat == 4:
		$Waddler2.visible = true
		$Waddler2.set_lerp($WaddlerPoint2.position)
	if beat == 6:
		$Waddler3.visible = true
		$Waddler3.set_lerp($WaddlerPoint3.position,.9)
	if beat == 7:
		$Waddler4.visible = true
		$Waddler4.set_lerp($WaddlerPoint4.position,.85)
	if beat == 8:
		$Waddler5.visible = true
		$Waddler5.set_lerp($WaddlerPoint5.position,.8)



	
	
func _on_timer_timeout() -> void:
	beat += 1
	beat_process()
	pass # Replace with function body.
