extends Node2D
var held = false
var start_pos = Vector2(0,0)
var shot = Line2D.new()
var body = []
var cellScene = preload("res://Ships/Components/ShipCell.tscn")
var cannon_loc = []
var selected_cannon = null
var selected_crew = null
var manager = preload("res://Ships/ShipManager.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_body_map()
	connect_cannons()

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click"):
		held = true
		if selected_cannon != null:
			create_shot()
		var cell =$TileMap.local_to_map(get_local_mouse_position())
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
		var atlas = $TileMap.get_cell_atlas_coords(0,cell)
#		print(atlas)
		$TileMap.set_cell(0,cell,1,atlas)
		update_body(cell,"damaged")


		
	
	shot.queue_free()
	pass

#updates the ships body
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
	selected_cannon = cannon
	pass


func cannon_shot(cannon_idx):
	$TileMap.get






#WORK AROUND FIX LATER
func _on_cannon_1_pressed():
	if selected_cannon == "cannon1":
		selected_cannon = null
	else:
		selected_cannon = "cannon1"
		
func _on_cannon_2_pressed():
	if selected_cannon == "cannon2":
		selected_cannon = null
	else:
		selected_cannon = "cannon2"
	pass # Replace with function body.


func _on_pink_selected():
	print("SELECTED")
	selected_crew = $Crew/Pink
	pass # Replace with function body.
