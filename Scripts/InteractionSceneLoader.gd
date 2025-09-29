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
			get_node("Control").add_child(load("res://Scenes/Interaction Scenes/AttachArmScene.tscn").instantiate())
		interaction.DirtCleaning:
			get_node("Control").add_child(load("res://Scenes/Interaction Scenes/CleaningScene.tscn").instantiate())
		interaction.GearInsert:
			get_node("Control").add_child(load("res://Scenes/Interaction Scenes/InsertGearScene.tscn").instantiate())
		interaction.VendingShake:
			get_node("Control").add_child(load("res://Scenes/Interaction Scenes/LegScrapSearchScene.tscn").instantiate())
		interaction.LegTwist:
			get_node("Control").add_child(load("res://Scenes/Interaction Scenes/AttachLegScene.tscn").instantiate())
	
	$AnimationPlayer.play("FadeIn")



func unload_scene():
	await get_tree().create_timer(1, PROCESS_MODE_ALWAYS).timeout
	$AnimationPlayer.play("FadeOut")
	get_tree().paused = false
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "FadeIn":
		get_tree().paused = true
	elif anim_name == "FadeOut":
		if get_node("Control").get_child_count() > 0:
			get_node("Control").get_child(0).queue_free()
