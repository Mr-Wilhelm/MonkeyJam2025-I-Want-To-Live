extends Sprite2D

func _physics_process(delta: float) -> void:
	position = Vector2(global_position.x+1, global_position.y)
