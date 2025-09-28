extends Node2D

var offset : Vector2 = Vector2(0, 75)
var range = 50
var complete: bool = false

var input_flags = []	
	
func _physics_process(delta: float) -> void:
	
	if input_flags.size() != 0:
		print("-----")
		print(input_flags)
		var lowest_z : Area2D = input_flags[0]
		for flag : Area2D in input_flags:
			print(flag.z_index)
			if flag.z_index > lowest_z.z_index:
				lowest_z = flag
	
		lowest_z.input_handled()

	input_flags = []
	
	if !complete:
		if $Connector.global_position.distance_to($RibbonCable.global_position - (offset * get_parent().scale.x)) < (range * get_parent().scale.x):
			complete = true
	else:
		$RibbonCable.global_position = $Connector.global_position + (offset * get_parent().scale.x)
		get_parent().get_parent().unload_scene()
