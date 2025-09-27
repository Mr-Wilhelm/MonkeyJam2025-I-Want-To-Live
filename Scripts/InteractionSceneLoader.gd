extends CanvasLayer

enum interaction {RibbonCable, ScrapSearch, Welding, DirtCleaning, GearInsert, VendingShake, LegTwist}


func load_scene(chosen_interaction : interaction):
	match chosen_interaction:
		interaction.RibbonCable:
			add_child(load("res://Prefabs/DebugTestingInteractionScene.tscn").instantiate()) # replace with each scene
		interaction.ScrapSearch:
			pass
		interaction.Welding:
			pass
		interaction.DirtCleaning:
			pass
		interaction.GearInsert:
			pass
		interaction.VendingShake:
			pass
		interaction.LegTwist:
			pass
