extends CharacterBody2D

@export var moveSpeed: float = 500
var moveDir: Vector2

func _physics_process(delta: float) -> void:
	moveDir.x = Input.get_axis("MoveLeft", "MoveRight")
	moveDir.y = Input.get_axis("MoveUp", "MoveDown")
	moveDir = moveDir.normalized()

	if moveDir.x > 0: %Sprite.flip_h = false
	elif moveDir.x < 0: %Sprite.flip_h = true
	
	if moveDir:
		velocity = moveDir * moveSpeed
		if %Sprite.animation != "walking": %Sprite.animation = "walking"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, moveSpeed)
		if %Sprite.animation != "idle": %Sprite.animation = "idle"
	move_and_slide()
