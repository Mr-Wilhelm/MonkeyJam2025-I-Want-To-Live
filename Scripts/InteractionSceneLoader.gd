extends CanvasLayer

enum interaction {RibbonCable, ScrapSearch, Welding, DirtCleaning, GearInsert, VendingShake, LegTwist}



func load_scene(chosen_interaction : interaction):
	match chosen_interaction:
		interaction.RibbonCable:
			get_node("Control").add_child(load("res://Scenes/Interaction Scenes/RibbonCableScene.tscn").instantiate()) # replace with each scene
			get_parent().get_node("Environ-Gate").texture = load("res://Art/Placeholder/icon.svg")
		interaction.ScrapSearch:
			get_node("Control").add_child(load("res://Scenes/Interaction Scenes/ScrapSearchScene.tscn").instantiate())
		interaction.Welding:
			pass
		interaction.DirtCleaning:
			get_node("Control").add_child(load("res://Scenes/Interaction Scenes/CleaningScene.tscn").instantiate())
		interaction.GearInsert:
			pass
		interaction.VendingShake:
			pass
		interaction.LegTwist:
			pass
	
	$AnimationPlayer.play("FadeIn")



func unload_scene():
	$AnimationPlayer.play("FadeOut")
	get_tree().paused = false
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "FadeIn":
		get_tree().paused = true
	elif anim_name == "FadeOut":
		get_node("Control").get_child(0).queue_free()
