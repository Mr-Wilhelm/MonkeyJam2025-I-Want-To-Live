extends Node2D

var offset : Vector2 = Vector2(1060, 500)
var range = 100

var complete: bool = false



var input_flags = []	
	
func _physics_process(delta: float) -> void:
	
	if input_flags.size() != 0:
		var lowest_z : Area2D = input_flags[0]
		for flag : Area2D in input_flags:
			if flag.z_index > lowest_z.z_index:
				lowest_z = flag
	
		lowest_z.input_handled()

	input_flags = []
	
	if !complete:
		if $TargetConnectionPoint.global_position.distance_to(($Leg.global_position)) < (range * get_parent().scale.x):
			$AudioStreamPlayer2D.play()
			complete = true
			get_parent().get_parent().unload_scene(6)

	else:
		$Leg.global_position = $TargetConnectionPoint.global_position 
		
