extends Node2D

@onready var interactLable: TextureRect = $Label
var currentInteractions := []	#list of interactable objects
var canInteract := true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and canInteract:
		if currentInteractions:		#checks if there are interactions around
			canInteract = false
			interactLable.hide()
			
			await currentInteractions[0].interact.call()	#calls the interact function of the object
			
			canInteract = true

func _process(_delta: float) -> void:
	if currentInteractions and canInteract:
		currentInteractions.sort_custom(SortByNearest)	#gets the nearest interactable
		if currentInteractions[0].canInteract:
			#interactLable.text = currentInteractions[0].interactName	
			interactLable.show()
	else:
		interactLable.hide()

func SortByNearest(area1, area2):
	var area1Distance = global_position.distance_to(area1.global_position)
	var area2Distance = global_position.distance_to(area2.global_position)
	
	return area1Distance < area2Distance

func _on_interact_range_area_entered(area: Area2D) -> void:
	print("Entered", area)
	currentInteractions.push_back(area)


func _on_interact_range_area_exited(area: Area2D) -> void:
	print("Exited", area)
	currentInteractions.erase(area)
