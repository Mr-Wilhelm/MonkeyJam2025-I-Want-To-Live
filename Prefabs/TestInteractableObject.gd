extends Node2D

@onready var interactable: Area2D = $Interactable
@onready var objectSprite: Sprite2D = $Sprite2D
@onready var minigameOverlay: CanvasLayer = $MinigameOverlay

func _ready() -> void:
	interactable.interact = Callable(self, "OnInteract")
	minigameOverlay.visible = false
	
	
func OnInteract() -> void:
	print("Interacted With", name)
	
	get_tree().paused = true
	
	minigameOverlay.visible = true	
	minigameOverlay.pause_mode = Node.PROCESS_MODE_PAUSABLE
