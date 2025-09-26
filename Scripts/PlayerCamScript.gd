extends Camera2D

@export var camZoomSpeed: float = 5.0
@export var zoomInVal: Vector2 = Vector2(0.5, 0.5)
@export var zoomOutVal: Vector2 = Vector2(1.5, 1.5)

var valToZoomTo: Vector2
var isFollowingPlayer: bool = false

func _ready() -> void:
	zoom = zoomOutVal
	valToZoomTo = zoom
	isFollowingPlayer = false
	
func _process(delta: float) -> void:
	zoom = zoom.lerp(valToZoomTo, camZoomSpeed * delta)
	
	if isFollowingPlayer:
		position = Vector2.ZERO
	
func SetCamToZoomIn() -> void:
	valToZoomTo = zoomInVal
	isFollowingPlayer = true

func SetCamToZoomOut() -> void:
	valToZoomTo = zoomOutVal
	isFollowingPlayer = false
