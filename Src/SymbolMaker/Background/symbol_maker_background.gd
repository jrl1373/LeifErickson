extends Node2D

@onready var OuterCornerShader = preload('res://Src/SymbolMaker/Background/SymbolBackground.gdshader')
@onready var InnerCornerShader = preload('res://Src/SymbolMaker/Background/SymbolBackgroundInnerCorner.gdshader')
var speed = 1;
var shader_on = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var outer_corners = get_tree().get_nodes_in_group('outercorners')
	for outer_corner in outer_corners:
		var new_shader = ShaderMaterial.new()
		outer_corner.material = new_shader
		outer_corner.material.shader = OuterCornerShader
		outer_corner.material.set_shader_parameter("on", shader_on)
		outer_corner.material.set_shader_parameter('speed', speed)
		speed += 5;
		
	var inner_corners = get_tree().get_nodes_in_group('innercorners')
	for inner_corner in inner_corners:
		var new_shader = ShaderMaterial.new()
		inner_corner.material = new_shader
		inner_corner.material.shader = InnerCornerShader
		inner_corner.material.set_shader_parameter("on", shader_on)
		inner_corner.material.set_shader_parameter('speed', speed)
		speed += 5;
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
