extends Node2D

@onready var dirtSprite: Sprite2D = $DirtSprite
@onready var area: Area2D = $DirtArea

var isCleaning: bool = false
var cleanRate: float = 0.01 #speed at which cleaning is done

func _ready() -> void:
	dirtSprite.modulate.a = 1.0
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			isCleaning = event.pressed	#true or false for event.pressed
			
	if event.is_action_pressed("DebugToggleCam"):
		print("beans on toast")
			
	
func _process(delta):
	if isCleaning:
		var mousePosGlobal = get_global_mouse_position()
		var mousePosLocal = to_local(mousePosGlobal)
		
		if dirtSprite.get_rect().has_point(mousePosLocal):
			scrub()
			
		print(get_parent().patchesCleaned)

func scrub():
	if dirtSprite.modulate.a > 0:
		dirtSprite.modulate.a = max(0.0, dirtSprite.modulate.a - cleanRate)
	else:
		objectClean()
		queue_free()

func objectClean():
	get_parent().patchesCleaned += 1
