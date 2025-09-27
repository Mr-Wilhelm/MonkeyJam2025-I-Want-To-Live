extends Node2D

@export var scene_to_load : int

@onready var interactable: Area2D = $Interactable
@onready var objectSprite: Sprite2D = $Sprite2D
var minigameOverlay: CanvasLayer

func _ready() -> void:
	interactable.interact = Callable(self, "OnInteract")
	minigameOverlay = get_parent().get_node("InteractionScene")
	
	
func OnInteract() -> void:
	print("Interacted with: " + name)	
	minigameOverlay.load_scene(scene_to_load)
	queue_free() 
