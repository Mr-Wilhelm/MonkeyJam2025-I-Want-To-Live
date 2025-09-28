extends Area2D

var dragging : bool = false
var drag_offset : Vector2 = Vector2.ZERO

var stored_event : InputEvent

func input_handled():
	if stored_event is InputEventMouseButton and stored_event.button_index == MOUSE_BUTTON_LEFT:
		if stored_event.pressed:
			dragging = true
			drag_offset = get_parent().global_position - get_global_mouse_position()
		else:
			dragging = false

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	stored_event = event
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_offset = get_parent().global_position - get_global_mouse_position()
			get_viewport().set_input_as_handled()
		else:
			dragging = false
			get_viewport().set_input_as_handled()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and dragging:
		
		get_viewport().set_input_as_handled()
		var scaled_viewport_size = get_viewport_rect().size*get_parent().get_parent().get_parent().scale.x
		#var scaled_viewport_size = get_viewport_rect().size
		var lower_bounds = get_viewport_rect().get_center() - scaled_viewport_size/2
		var upper_bounds = get_viewport_rect().get_center() +scaled_viewport_size/2
		var deadzone_offset = 50 * get_parent().get_parent().get_parent().scale.x
		#var deadzone_offset = 50 
		
		get_parent().global_position = get_global_mouse_position() + drag_offset
		if get_parent().global_position.x < lower_bounds.x + deadzone_offset:
			get_parent().global_position.x = lower_bounds.x + deadzone_offset
		elif get_parent().global_position.x > upper_bounds.x - deadzone_offset:
			get_parent().global_position.x = upper_bounds.x - deadzone_offset
		if get_parent().global_position.y < lower_bounds.y + deadzone_offset:
			get_parent().global_position.y = lower_bounds.y + deadzone_offset
		elif get_parent().global_position.y > upper_bounds.y - deadzone_offset:
			get_parent().global_position.y = upper_bounds.y - deadzone_offset
		
		if get_global_mouse_position().x < lower_bounds.x:
			dragging = false
		elif get_global_mouse_position().x > upper_bounds.x:
			dragging = false
		if get_global_mouse_position().y < lower_bounds.y:
			dragging = false
		elif get_global_mouse_position().y > upper_bounds.y:
			dragging = false
