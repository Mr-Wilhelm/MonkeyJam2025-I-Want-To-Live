extends Node2D

var offset : Vector2 = Vector2(0, 75)
var range = 50
var complete: bool = false

func _physics_process(delta: float) -> void:
	
	print(get_parent().scale.x)
	if !complete:
		if $Connector.global_position.distance_to($RibbonCable.global_position - (offset * get_parent().scale.x)) < (range * get_parent().scale.x):
			complete = true
	else:
		$RibbonCable.global_position = $Connector.global_position + (offset * get_parent().scale.x)
		get_parent().get_parent().unload_scene()
