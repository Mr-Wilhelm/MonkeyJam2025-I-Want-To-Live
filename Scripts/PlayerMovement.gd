extends CharacterBody2D

@export var moveSpeed: float = 500
var moveDir: Vector2

func _physics_process(delta: float) -> void:
	moveDir.x = Input.get_axis("MoveLeft", "MoveRight")
	moveDir.y = Input.get_axis("MoveUp", "MoveDown")
	moveDir = moveDir.normalized()
	
	if moveDir:
		velocity = moveDir * moveSpeed
		
		if abs(moveDir.x) > abs(moveDir.y):
			if moveDir.x > 0:
				if %Sprite.animation != "WalkRight":
					%Sprite.animation = "WalkRight"
			else:
				if %Sprite.animation != "WalkLeft":
					%Sprite.animation = "WalkLeft"
		else:
			if moveDir.y > 0:
				if %Sprite.animation != "WalkDown":
					%Sprite.animation = "WalkDown"
			else:
				if %Sprite.animation != "WalkUp":
					%Sprite.animation = "WalkUp"
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
