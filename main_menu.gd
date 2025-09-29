extends Control


func _on_play_pressed() -> void:
	queue_free()
	get_parent().get_node("PlayerCam").menuCamActive = false
	self.get_rect()
	


func _on_quit_pressed() -> void:
	get_tree().quit()
