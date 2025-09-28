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
	
	if stored_event is InputEventMouseMotion and dragging:
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
			
	stored_event = null
			
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		stored_event = event
	elif stored_event == null:
		stored_event = event
	if stored_event != null:
		get_parent().get_parent().input_flags.append(self)
	


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and !event.pressed:
		dragging = false
	if event is InputEventMouseMotion and dragging:
		stored_event = event
		input_handled()
	#if event is InputEventMouseMotion:
		#stored_event = event
#	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
#		if !event.pressed and stored_event == null:
#			stored_event = event
	
	#if stored_event != null:
		#get_parent().get_parent().input_flags.append(self)
	#pass
	
	
