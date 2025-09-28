extends Area2D

var complete: bool = false

var stored_event : InputEvent
var dragging = false # not used

func input_handled():
	if stored_event is InputEventMouseButton and stored_event.button_index == MOUSE_BUTTON_LEFT:
		if stored_event.pressed:
			if !complete:
				complete = true
				get_parent().get_node("AnimationPlayer").play("Flash")

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	stored_event = event
	
	get_parent().get_parent().input_flags.append(self)
	
	
	
			
