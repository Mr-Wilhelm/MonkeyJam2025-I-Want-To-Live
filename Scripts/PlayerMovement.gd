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

#currently set to semicolon (;) for the debug option, normally this function will be called from elsewhere
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("DebugToggleCam") && %PlayerCam.isFollowingPlayer == false:
		%PlayerCam.SetCamToZoomIn()
	elif event.is_action_pressed("DebugToggleCam") && %PlayerCam.isFollowingPlayer == true:
		%PlayerCam.SetCamToZoomOut()
