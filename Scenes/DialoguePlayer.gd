extends Node2D

@export var dialogueToPlay: AudioStream




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$AudioStreamPlayer2D.stream = dialogueToPlay
		$AudioStreamPlayer2D.play()# Replace with function body.
		print("Playing Audio")
