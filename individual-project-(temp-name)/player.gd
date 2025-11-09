extends CharacterBody2D

@export var speed = 120
@export var gravity = 30
@export var health = 100
@export var jump_force = 500

signal player_dead

func _physics_process(_delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
		
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	move_and_slide()
	
	if velocity.x > 0:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play("run")
	elif velocity.x < 0:
		$Sprite2D.flip_h = true
		$AnimationPlayer.play("run")
	elif velocity.x == 0:
		$AnimationPlayer.play("idle")
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		$AnimationPlayer.play("jump")
		velocity.y = -jump_force
	
	if position.y >= 100:
		hurt(100)
	
	
func hurt(damage):
	$Sprite2D.modulate = "#ff0000"
	await get_tree().create_timer(.5).timeout
	$Sprite2D.modulate = "#ffffff"
	health -= damage
	if health <= 0:
		player_dead.emit()
