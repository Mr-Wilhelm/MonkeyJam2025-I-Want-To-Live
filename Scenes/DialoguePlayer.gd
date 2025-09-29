extends Node2D

@export var dialogueToPlay: AudioStream

func _on_area_2d_area_entered(area: Area2D) -> void:
	$AudioStreamPlayer2D.stream = dialogueToPlay
	$AudioStreamPlayer2D.play()# Replace with function body.
	print("Playing Audio")
