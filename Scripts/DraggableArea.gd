extends Area2D

var dragging : bool = false
var drag_offset : Vector2 = Vector2.ZERO

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_offset = get_parent().global_position - get_global_mouse_position()
		else:
			dragging = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and dragging:
		var lower_bounds = get_viewport_rect().get_center() - get_viewport_rect().size/2
		var upper_bounds = get_viewport_rect().get_center() + get_viewport_rect().size/2
		var deadzone_offset = 50
		
		get_parent().global_position = get_global_mouse_position() + drag_offset
		if get_parent().global_position.x < lower_bounds.x + deadzone_offset:
			get_parent().global_position.x = lower_bounds.x + deadzone_offset
			dragging = false
		elif get_parent().global_position.x > upper_bounds.x - deadzone_offset:
			get_parent().global_position.x = upper_bounds.x - deadzone_offset
			dragging = false
		if get_parent().global_position.y < lower_bounds.y + deadzone_offset:
			get_parent().global_position.y = lower_bounds.y + deadzone_offset
			dragging = false
		elif get_parent().global_position.y > upper_bounds.y - deadzone_offset:
			get_parent().global_position.y = upper_bounds.y - deadzone_offset
			dragging = false
		
