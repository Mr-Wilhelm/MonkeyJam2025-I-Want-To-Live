extends CanvasLayer

enum interaction {RibbonCable, ScrapSearch, Welding, DirtCleaning, GearInsert, VendingShake, LegTwist}

var pos = Vector2(833, -991)
var Beep1 = Vector2(1725, 1523)
var Beep2 = Vector2(1551, 360)
var Beep3 = Vector2(-159, -1469)

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



func unload_scene(prev : int):
	await get_tree().create_timer(1, PROCESS_MODE_ALWAYS).timeout
	$AnimationPlayer.play("FadeOut")
	get_tree().paused = false
	
	if prev == 0:
		get_parent().get_node("InteractPrompt-ScrapSearch").visible = true
		get_parent().get_node("Player/AudioStreamPlayer2D2").stream = load("res://Audio/SceneDialogue/Scene2-3.mp3")
		get_parent().get_node("Player/AudioStreamPlayer2D2").play()
		var x = load("res://Prefabs/BeepingMechanic/BeepingObject.tscn").instantiate()
		print("Nerd")
		x.global_position = get_parent().get_node("InteractPrompt-ScrapSearch").global_position
		get_parent().add_child(x)
		
	elif prev == 1:
		get_parent().get_node("InteractPrompt-ArmAttach").global_position = pos
		get_parent().get_node("Player/AudioStreamPlayer2D2").stream = load("res://Audio/SceneDialogue/Scene3-3.mp3")
		get_parent().get_node("Player/AudioStreamPlayer2D2").play()
	elif prev == 2:
		get_parent().get_node("InteractPrompt-Cleaning").visible = true
		get_parent().get_node("Player/AudioStreamPlayer2D2").stream = load("res://Audio/SceneDialogue/Scene4-2.mp3")
		get_parent().get_node("Player/AudioStreamPlayer2D2").play()
		var x = load("res://Prefabs/BeepingMechanic/BeepingObject.tscn").instantiate()
		x.global_position = get_parent().get_node("InteractPrompt-Cleaning").global_position
		get_parent().add_child(x)
	elif prev == 3:
		get_parent().get_node("InteractPrompt-GearInsert").global_position = pos
		get_parent().get_node("Player/AudioStreamPlayer2D2").stream = load("res://Audio/SceneDialogue/Scene5-3.mp3")
		get_parent().get_node("Player/AudioStreamPlayer2D2").play()
	elif prev == 4:
		get_parent().get_node("InteractPrompt-LegSearch").visible = true
		get_parent().get_node("Player/AudioStreamPlayer2D2").stream = load("res://Audio/SceneDialogue/Scene6-3.mp3")
		get_parent().get_node("Player/AudioStreamPlayer2D2").play()
		var x = load("res://Prefabs/BeepingMechanic/BeepingObject.tscn").instantiate()
		x.global_position = get_parent().get_node("InteractPrompt-LegSearch").global_position
		get_parent().add_child(x)
	elif prev == 5:
		get_parent().get_node("InteractPrompt-LegAttach").global_position = pos
		get_parent().get_node("Player/AudioStreamPlayer2D2").stream = load("res://Audio/SceneDialogue/Scene7-3.mp3")
		get_parent().get_node("Player/AudioStreamPlayer2D2").play()
	elif prev == 6:
		get_parent().get_node("Player/AudioStreamPlayer2D2").stream = load("res://Audio/SceneDialogue/Scene8-2.mp3")
		get_parent().get_node("Player/AudioStreamPlayer2D2").play()
		
	
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "FadeIn":
		get_tree().paused = true
	elif anim_name == "FadeOut":
		if get_node("Control").get_child_count() > 0:
			get_node("Control").get_child(0).queue_free()
