extends Node2D
var cell_pos = Vector2i(0,0)
var astar_grid = AStarGrid2D.new()
var grid_size = Vector2i(64,64)
@export var cell_size = Vector2i(16, 16)


signal selected
# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_grid()

func initialize_grid():

	astar_grid.size = grid_size
	astar_grid.cell_size = cell_size
#	astar_grid.offset = cell_size / 2
	astar_grid.update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
#	if Input.is_action_just_pressed("click"):
#		var cell = floor(get_local_mouse_position()/16)
		
	pass

func go_to_cell(cell):
	print("test")
	var path = PackedVector2Array(astar_grid.get_point_path(cell_pos, cell))
	print(path)


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		selected.emit()
	pass # Replace with function body.
