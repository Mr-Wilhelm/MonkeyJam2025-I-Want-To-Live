extends Area2D

var complete: bool = false

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if !complete:
				complete = true
				get_parent().get_node("AnimationPlayer").play("Flash")
