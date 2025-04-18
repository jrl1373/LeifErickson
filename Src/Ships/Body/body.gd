#main ship body node, connects ship, crews, and cannon
extends Node2D
var held = false
var start_pos = Vector2(0,0)
var shot = Line2D.new()
var body = []
var cellScene = preload("res://src/Ships/Components/ShipCell.tscn")
@export var lineProjectile : PackedScene
var cannon_loc = []
var selected_cannon = null
var selected_crew = null
var manager = preload("res://Src/Ships/ShipManager.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_body_map()
	connect_cannons()
	for crew in $Crew.get_children():
		crew.update_cell_pos($TileMap.local_to_map(crew.position))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click"):
		held = true
		if selected_cannon != null:
			create_shot()
		var cell = $TileMap.local_to_map(get_local_mouse_position())
		print(cell)
		print(selected_crew)
		if selected_crew != null:
			print("testing")
			selected_crew.go_to_cell(cell)
		
	if Input.is_action_just_released("click"):
		held = false
		#possible bug FIX
		if selected_cannon != null:
			shoot_shot()
	if held == true and selected_cannon != null:
		
		shot.set_point_position(1,get_local_mouse_position())

#creates cannonball with starting position
#creates a line and initializes it's starting point at mouse location
func create_shot():
	shot = Line2D.new()
	shot.width = 1
	start_pos = get_local_mouse_position()
	self.add_child(shot)
	shot.add_point(start_pos)
	shot.add_point(start_pos)

#shoots cannonball and emits damaged cells
func shoot_shot():
	
	var cells = []
	if is_instance_valid(shot):
		var p1 = shot.get_point_position(0) - $TileMap.position
		var p2 = shot.get_point_position(1) - $TileMap.position
	#calculate distance between points
		var hits = floor(p1.distance_to(p2))
		var point = p1
		
		for i in range(hits):
			point = p1.lerp(p2,i/hits)
			var cell = $TileMap.local_to_map(point)
			if !cell in cells:
				print(cell)
				cells.append(cell)
		for cell in cells:
			var atlas = $TileMap/Layer1.get_cell_atlas_coords(cell)
			print("atlas coord")
			print(atlas)
			$TileMap/Layer1.set_cell(cell,1,atlas,0)
			update_body(cell,"damaged")
		shot.queue_free()
	pass

#updates the ships body
#loc: cell location
#sig: signal so send to ShipCell
func update_body(loc,sig):
	if loc.y >= 0 and loc.y < body.size() and loc.x >= 0 and loc.x < body[0].size():
		if body[loc.y][loc.x] != null:
			body[loc.y][loc.x].update(sig)

#generates ship cell map details
func generate_body_map():
	var size = $TileMap.tile_set.get_source(0).get_atlas_grid_size()
	for y in range(size.y):
		body.append([])
		for x in range(size.x):
			var cell = $TileMap.get_cell_atlas_coords(0,Vector2i(x,y))
			if cell == Vector2i(-1,-1):
				body[y].append(null)
			else:
				var new_cell = cellScene.instantiate()
				body[y].append(new_cell)
	print(body)

#connects cannons to cannon select signals
func connect_cannons():
	var cannons = $Cannons.get_children()
	for cannon in cannons:
		cannon.selected.connect(_cannon_selected)

#selects cannon
func _cannon_selected(cannon):
	get_tree().call_group("Selectable", "deselect")
	cannon.select()
	selected_cannon = cannon
	selected_crew = null
	pass


func cannon_shot(cannon_idx):
	pass




#
##WORK AROUND FIX LATER
#func _on_cannon_1_pressed():
	#if selected_cannon == "cannon1":
		#selected_cannon = null
	#else:
		#selected_cannon = "cannon1"
		#
#func _on_cannon_2_pressed():
	#if selected_cannon == "cannon2":
		#selected_cannon = null
	#else:
		#selected_cannon = "cannon2"
	#pass # Replace with function body.



func _on_pink_selected(name):
	get_tree().call_group("Selectable", "deselect")
	name.select()
	selected_crew = name
	selected_cannon = null
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	var projectile = lineProjectile.instantiate()
	print(projectile.get_child(0).get_child(0).shape)
	var length = randi_range(10, 20)
	projectile.heading = randi_range(135, 225)
	projectile.velocity = randi_range(25, 75)
	projectile.length = length
	
	
	self.add_child(projectile)
	
	
	
	
	
	
	
	pass # Replace with function body.
