extends Node2D
var direction = Vector2.ZERO
var heading = 0
var speed = 300
var health = 100
var invincible = false
var last_direction = 'down'
var animation = "down"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = Vector2.ZERO
	heading = 0
	if Input.is_action_pressed("left"):
			direction.x = -1
			animation = "left"
	if Input.is_action_pressed("right"):
			direction.x = 1
			animation = "right"

	if Input.is_action_pressed("up"):
			direction.y = -1
			animation = "up"
	if Input.is_action_pressed("down"):
			direction.y = +1
			animation = "down"
	if direction == Vector2.ZERO:
		$AnimatedSprite2D.animation = "idle_"+animation
	else:
		change_animation(animation)

	position += direction.normalized() * speed * delta
	
func change_animation(direction):
	var cur_animation = $AnimatedSprite2D.animation
	$AnimatedSprite2D.animation = "running_"+direction
	
func hit(damage):
	if not invincible:
		print($AnimatedSprite2D.modulate)
		health = max(0,health - damage)
		$HealthBar.value = health
		invincible = true
		$AnimatedSprite2D.modulate = Color(1,.5,.5,1)
		$InvincibleTimer.start()
	
	


func _on_invincible_timer_timeout() -> void:
	$AnimatedSprite2D.modulate = Color(1,1,1,1)
	invincible = false
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	hit(area.damage)
	pass # Replace with function body.
