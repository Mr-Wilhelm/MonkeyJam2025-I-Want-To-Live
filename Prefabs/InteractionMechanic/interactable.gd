extends Area2D

@export var interactName: String = ""
@export var canInteract: bool = true

var interact: Callable = func():
	get_parent().OnInteract()
