extends Node2D


var input_flags = []

func _physics_process(delta: float) -> void:
	
	if input_flags.size() != 0:
		#print("-----")
		#print(input_flags)
		var lowest_z : Area2D = input_flags[0]
		for flag : Area2D in input_flags:
			#print(flag.z_index)
			#print(flag.stored_event.get_class())
			#print(flag.dragging)
			if flag.z_index > lowest_z.z_index:
				lowest_z = flag
	
		lowest_z.input_handled()

	input_flags = []





func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_parent().get_parent().unload_scene()
