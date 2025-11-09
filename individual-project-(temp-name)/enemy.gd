extends CharacterBody2D


const SPEED = 75
@export var gravity = 30


func _physics_process(_delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	if velocity.x < 0:
		$Sprite2D.flip_h = false
	elif velocity.x > 0:
		$Sprite2D.flip_h = true
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "Player":
			collision.get_collider().hurt(15)
	if position.y > 100:
		queue_free()

func _ready() -> void:
	while true:
		velocity.x = SPEED
		await get_tree().create_timer(1.5).timeout
		velocity.x = -SPEED
		await get_tree().create_timer(1.5).timeout
