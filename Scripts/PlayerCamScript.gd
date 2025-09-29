extends Camera2D

@export var camZoomSpeed: float = 5.0
@export var zoomInVal: Vector2 = Vector2(1.5, 1.5)
@export var zoomOutVal: Vector2 = Vector2(0.5, 0.5)

var menuCamActive : bool = true

var valToZoomTo: Vector2
var isFollowingPlayer: bool = false

func _ready() -> void:
	zoom = zoomInVal
	valToZoomTo = zoom
	isFollowingPlayer = true
	
func _process(delta: float) -> void:
	zoom = zoom.lerp(valToZoomTo, camZoomSpeed * delta)
	
	if menuCamActive:
		position = get_parent().get_node("MainMenu").get_rect().get_center() # Change to main menu cam location
	elif isFollowingPlayer:
		position = %Player.position
	else:
		position = Vector2(960, 540)
	
func SetCamToZoomIn() -> void:
	valToZoomTo = zoomInVal
	isFollowingPlayer = true

func SetCamToZoomOut() -> void:
	valToZoomTo = zoomOutVal
	isFollowingPlayer = false
