extends CharacterBody2D

@export var cannon: PackedScene
signal shot
# Declare member variables
var speed = 0
var max_speed = 200
var acceleration = 100
var deceleration = 50
var rotation_speed = 2

# Declare member variables for animations (TODO: Assign these in the editor)


# Function to handle ship movement
func _process(delta):
	var input_vector = Vector2()
	
	# Rotate the ship left and right
	if Input.is_action_just_released("shoot"):
		shot.emit()
		print("SHOOT")
#		var shot = cannon.instantiate()
#		shot.position = self.position
#		shot.heading = self.rotation
#		add_child(shot)
	
	if Input.is_action_pressed("ui_left"):
		rotation -= rotation_speed * delta
	elif Input.is_action_pressed("ui_right"):
		rotation += rotation_speed * delta

	# Accelerate and decelerate the ship
	if Input.is_action_pressed("ui_up"):
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
		# TODO: Play moving animation

	elif Input.is_action_pressed("ui_down"):
		speed -= deceleration * delta
		if speed < 0:
			speed = 0
		# TODO: Play idle animation

#	else:
#		speed = lerp(speed, 0, 0.05)
		# TODO: Play idle animation if speed is close to zero
#        if abs(speed) < 1:

	# Move the ship
	var velocity = Vector2(speed, 0).rotated(rotation-((PI)/2))
	self.velocity = velocity
	move_and_slide()
