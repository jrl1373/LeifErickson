extends Node2D

var beat = 0
var enemies = []
var beatmap = []
var queued_projectiles = []
var new_timer = null
signal projectile(origin,velocity,heading)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BG/Waddler3.visible = true
	$BG/Waddler3.set_lerp($WaddlerPoint.position)
	for i in $BG.get_children():
		enemies.append(i)
	#for i in range(10000):
		#beatmap.append([i%enemies.size(),300,0])
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#called every beat
func beat_process():
	$Label.text = str(beat)
	if beatmap.size() !=0:
		var projectile = beatmap[beat]
		if projectile:
			trig_proj(projectile)
	match beat:
		4:
			$BG/Waddler2.visible = true
			$BG/Waddler2.set_lerp($WaddlerPoint2.position)
		6:
			$BG/Waddler4.visible = true
			$BG/Waddler4.set_lerp($WaddlerPoint3.position,.9)
		8:
			$BG/Waddler.visible = true
			$BG/Waddler.set_lerp($WaddlerPoint4.position,.85)
		10:
			multi_projectile([0,1,2,3,0,1,2,3,0,1,2,3], fill_list(600,12), fill_list(0,12),1.0/64.0)
			pass
	if beat % 4 == 0:
		multi_projectile([0,1,2,3,0,1,2,3,0,1,2,3], fill_list(600,12), fill_list(0,12),1.0/64.0)
			


func fill_list(val,amount):
	var lst = []
	for i in range(amount):
		lst.append(val)
	return lst

func multi_projectile(origins,velocities,headings,split:float):
	new_timer = Timer.new()
	new_timer.timeout.connect(_multi_timer_timeout)
	self.add_child(new_timer)
	print(split)
	new_timer.wait_time = .48 * split
	new_timer.start()
	for i in range(origins.size()):
		queued_projectiles.append([origins[i],velocities[i],headings[i]])
	
func _multi_timer_timeout():
	var proj = queued_projectiles.pop_front()
	if !proj:
		new_timer.queue_free()
	else:
		trig_proj(proj)


func trig_proj(proj):
	projectile.emit(enemies[proj[0]].position,proj[1],proj[2])
	pass


	
	
func _on_timer_timeout() -> void:
	beat += 1
	beat_process()
	pass # Replace with function body.
