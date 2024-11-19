extends Node2D
var cell_pos = Vector2i(0,0)
var astar_grid = AStarGrid2D.new()
var grid_size = Vector2i(64,64)
var curr_path = PackedVector2Array()
var path_t = 0
var speed = 2

@export var cell_size = Vector2i(16, 16)


signal selected(name)
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
	
	if curr_path.size() > 0:
		$AnimatedSprite2D.play()
		if position == curr_path[0]:
			cell_pos = curr_path[0]/16
			curr_path.remove_at(0)
			path_t = 0
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.rotation = 0
		else:
			var angle = position.angle_to_point(curr_path[0])

			$AnimatedSprite2D.rotation = angle + PI/2
			path_t= min(1,path_t + (speed * delta))
			var test_pos = position
			position = position.lerp(curr_path[0],path_t)
	
	
#	if Input.is_action_just_pressed("click"):
#		var cell = floor(get_local_mouse_position()/16)
		
	pass
func update_cell_pos(cell):
	cell_pos = cell
	
func go_to_cell(cell):
	print(cell)
	var path = PackedVector2Array(astar_grid.get_point_path(cell_pos, cell))
	print(path)
	curr_path = path
	
	
func select():
	$AnimatedSprite2D.material.set_shader_parameter("onoff",1)

func deselect():
		$AnimatedSprite2D.material.set_shader_parameter("onoff",0)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		selected.emit(self)
	pass # Replace with function body.
