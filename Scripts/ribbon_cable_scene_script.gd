extends Node2D

var offset : Vector2 = Vector2(0, 75)
var complete: bool = false


func _physics_process(delta: float) -> void:
	if !complete:
		if $Connector.global_position.distance_to($RibbonCable.global_position - offset) < 50:
			complete = true
	else:
		$RibbonCable.global_position = $Connector.global_position + offset
		get_parent().get_parent().get_parent().unload_scene()
